//
//  ListingCell.swift
//  Galaxia
//
//  Created by Kiran on 27/09/23.
//

import UIKit
import Kingfisher

class ListingCell: UITableViewCell {
    static let identifire: String = "ListingCell"
    @IBOutlet weak var bookBrn: R_UIView!

    @IBOutlet weak var descriptionTxt: WTGLabel!
    @IBOutlet weak var headerTxt: WTGLabel!
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var ima: UIImageView!
    @IBOutlet weak var bg1: UIView!
    var galaxiaList: GalaxiaList?{
        didSet{
            self.headerTxt.text = galaxiaList?.title?.capitalized ?? ""
            self.descriptionTxt.text = galaxiaList?.description ?? ""
            let url = URL(string: galaxiaList?.imageurl ?? "")
            ima.kf.setImage(with: url,placeholder: UIImage(named: "No-Image-Placeholder.svg"))
            ima.contentMode = .scaleAspectFill
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let gradientColors = [UIColor(named: "gradient_002F75") ?? UIColor.red, UIColor(named: "gradient_5135B4") ?? UIColor.white]

        bookBrn.setGradientBackground(view: bookBrn, colors: gradientColors)
        


    }

    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [CACornerMask]
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension UIView{
    
    enum RoundCornersAt{
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
    }
    
        //multiple corners using CACornerMask
    func roundCorners(corners:[RoundCornersAt], radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [
            corners.contains(.topRight) ? .layerMaxXMinYCorner:.init(),
            corners.contains(.topLeft) ? .layerMinXMinYCorner:.init(),
            corners.contains(.bottomRight) ? .layerMaxXMaxYCorner:.init(),
            corners.contains(.bottomLeft) ? .layerMinXMaxYCorner:.init(),
        ]
    }
    
}
