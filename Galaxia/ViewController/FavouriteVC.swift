//
//  FavouriteVC.swift
//  Galaxia
//
//  Created by Kiran on 27/09/23.
//

import UIKit

class FavouriteVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: FavouriteCell.identifire, bundle: nil), forCellReuseIdentifier: FavouriteCell.identifire)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    @IBAction func backBtn(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
}

extension FavouriteVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.identifire, for: indexPath) as! FavouriteCell
        return cell
    }
    
    
}
