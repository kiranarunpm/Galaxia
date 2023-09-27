//
//  FavouriteCell.swift
//  Galaxia
//
//  Created by Kiran on 27/09/23.
//

import UIKit

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var bookBrn: R_UIView!
    static let identifire: String = "FavouriteCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        let gradientColors = [UIColor(named: "gradient_002F75") ?? UIColor.red, UIColor(named: "gradient_5135B4") ?? UIColor.white]

        bookBrn.setGradientBackground(view: bookBrn, colors: gradientColors)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    
}
