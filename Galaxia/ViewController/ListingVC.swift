//
//  ListingVC.swift
//  Galaxia
//
//  Created by Kiran on 27/09/23.
//

import UIKit
import AlignedCollectionViewFlowLayout
import MBProgressHUD
class ListingVC: UIViewController {
    var selectedIndex = 0
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: CategoryCell.identifire, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifire)
            let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .justified, verticalAlignment: .center)
            alignedFlowLayout.scrollDirection = .horizontal
            collectionView?.collectionViewLayout = alignedFlowLayout
//            let layout = UICollectionViewFlowLayout()
//                   layout.scrollDirection = .horizontal
//                   layout.minimumInteritemSpacing = 0
//                   layout.minimumLineSpacing = 5
//                   layout.estimatedItemSize = CGSize(width: 100, height: 50)
//                   self.collectionView.collectionViewLayout = layout
        }
    }
    var arr = ["Recommended", "Price", "Distance", "Class"]
    
    @IBOutlet weak var navTitle: WTGLabel!
    @IBOutlet weak var navTitleConst: NSLayoutConstraint!
    @IBOutlet weak var searchView: R_UIView!
    @IBOutlet weak var searchBottomConst: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    lazy var viewModel: ListViewModel = {
        return ListViewModel()
    }()
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: ListingCell.identifire, bundle: nil), forCellReuseIdentifier: ListingCell.identifire)
            tableView.register(UINib(nibName: SpaceCell.identifire, bundle: nil), forCellReuseIdentifier: SpaceCell.identifire)

            tableView.separatorStyle = .none
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        let gradientColors = [ UIColor(named: "gradient_5135B4") ?? UIColor.white, UIColor(named: "gradient_002F75") ?? UIColor.red]
        setGradientBackground(view: headerView, colors: gradientColors)
        initViewModel()
        
        if ScreenSize.SCREEN_WIDTH <= 375 || DeviceType.IS_IPHONE_7PLUS{
            headerHeight.constant = 140
        }

    }
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.goBack()
    }
    func setGradientBackground(view: UIView, colors: [UIColor]) {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // Convert UIColors to CGColors
        let cgColors = colors.map { $0.cgColor }
        
        gradientLayer.colors = cgColors
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    // MARK: InitViewModel
    func initViewModel() {
        
        viewModel.successClosure = { [weak self] () in
            
            guard let _self = self else { return }
            
            DispatchQueue.main.async {
                _self.tableView.reloadData()
            }
        }
        
        viewModel.failureClosure = { [weak self] () in
            
            guard let _self = self else { return }
            
            DispatchQueue.main.async {
                
                if let alertMessage = _self.viewModel.alertMessage {
                    print("alertMessage", alertMessage)
                    
                }
            }
        }
        
        viewModel.loadingStatus = { [weak self] () in
            
            guard let _self = self else { return }
            
            DispatchQueue.main.async {
                
                let isLoading = _self.viewModel.isLoading ?? false
                
                if isLoading {
                    MBProgressHUD.showAdded(to: _self.view, animated: true)
                    
                }else {
                    MBProgressHUD.hide(for: _self.view, animated: true)
                }
            }
        }
        
        viewModel.callList()
    }
    

}

extension ListingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
        let index = arr[indexPath.row]
        cell.txt.text = index
        
        if selectedIndex == indexPath.row{
            cell.txt.textColor = UIColor.white
            cell.txt.font = UIFont.WTGfont(.bold, size: 14)
            cell.indicatorView.backgroundColor = UIColor.white

            
        }else{
            cell.txt.textColor = UIColor(named: "blue_6C8DE9")
            cell.txt.font = UIFont.WTGfont(.medium, size: 14)
            cell.indicatorView.backgroundColor = UIColor.clear
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.collectionView.reloadData()
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let index = arr[indexPath.row]

        let modeldata = index
        let cellWidth = (modeldata.size(withAttributes:[.font: UIFont.WTGfont(.regular,size: 14)]).width ) + 25
        return CGSize(width: cellWidth, height: 45.0)

    }
    
}

extension ListingVC: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return viewModel.listResponse?.result?.count ?? 0
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: ListingCell.identifire, for: indexPath) as! ListingCell
            let indx = viewModel.listResponse?.result?[indexPath.row]
            cell.galaxiaList = indx
            if indexPath.row == 0{
                cell.favBtn.setImage(UIImage(named: "favImg"), for: .normal)
            }else{
                cell.favBtn.setImage(UIImage(named: "unfav"), for: .normal)

            }
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: SpaceCell.identifire, for: indexPath) as! SpaceCell
            cell.selectionStyle = .none
            return cell

        }
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 50 {
                  print("moved")
            UIView.animate(withDuration: 0.3
            ) {
                self.searchView.alpha = 1
                self.navTitle.alpha = 0


                self.searchBottomConst.constant = 60
                self.navTitleConst.constant = 30
                self.view.layoutIfNeeded()


            }
            self.view.layoutIfNeeded()

            

               } else if scrollView.contentOffset.y > 50 {
                   UIView.animate(withDuration: 0.3) {
                       self.searchBottomConst.constant = 200
                       self.navTitleConst.constant = 70
                       self.navTitle.alpha = 1
                       self.searchView.alpha = 0
                       self.view.layoutIfNeeded()
                       

                   }
                   
                   



               }
    }
    
    
}
