//
//  HomeVC.swift
//  Galaxia
//
//  Created by Kiran on 26/09/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var pageControl: CustomPageControl!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        pageControl.currentPageImage = UIImage(named: "Ellipse 149")
        pageControl.otherPagesImage = UIImage(named: "Ellipse 150")
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(UINib(nibName: GalleryCell.identifire, bundle: nil), forCellWithReuseIdentifier: GalleryCell.identifire)
        
        self.galleryCollectionView.showsHorizontalScrollIndicator = false
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 200)
        floawLayout.scrollDirection = .vertical
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 0.2
        floawLayout.spacingMode = .overlap(visibleOffset: 70)
        galleryCollectionView.collectionViewLayout = floawLayout
        galleryCollectionView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false

    }
    
    // MARK: Set Page index
    fileprivate var pageSize: CGSize {
        let layout = self.galleryCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    

    @IBAction func listingBtn(_ sender: Any) {
        let vc = ListingVC.instantiate(fromAppStoryboard: .Main)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifire, for: indexPath) as! GalleryCell
        return cell
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if collectionView == galleryCollectionView {
//            if pageControl.currentPage == indexPath.row {
//                guard let visible = galleryCollectionView.visibleCells.first else { return }
//                guard let index = galleryCollectionView.indexPath(for: visible)?.row else { return }
//                pageControl.currentPage = index
//            }
//
//        }
//    }
 
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == galleryCollectionView {
                guard let visible = galleryCollectionView.visibleCells.first else { return }
                guard let index = galleryCollectionView.indexPath(for: visible)?.row else { return }
                pageControl.currentPage = index

            
        }
    }
    
    
}
