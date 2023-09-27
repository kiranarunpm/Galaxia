//
//  RoundedTabBarController.swift
//  Galaxia
//
//  Created by Kiran on 27/09/23.
//

import UIKit

class RoundedTabBarController: UITabBarController {
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.3)
        
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor(named: "black_10101B"),
            NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: 30) ,
        ]
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        if ScreenSize.SCREEN_WIDTH <= 375 || DeviceType.IS_IPHONE_7PLUS{
            self.tabBar.items?.forEach({ item in
                item.title = " "
            })
        }
        else{
            self.tabBar.items?.forEach({ item in
                item.title = ""
            })
            
        }
        
        let layer = CAShapeLayer()
        if ScreenSize.SCREEN_WIDTH <= 375 ||  DeviceType.IS_IPHONE_7PLUS{
            layer.path = UIBezierPath(roundedRect: CGRect(x: 20, y: tabBar.bounds.minY + -40, width: tabBar.bounds.width - 40, height: 82), cornerRadius: (26)).cgPath
            
        }
        
        else{
            layer.path = UIBezierPath(roundedRect: CGRect(x: 20, y: tabBar.bounds.minY + -20, width: tabBar.bounds.width - 40, height: 82), cornerRadius: (26)).cgPath
        }
        
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor(named: "black_10101B")?.cgColor
        
        tabBar.layer.insertSublayer(layer, at: 0)
        if ScreenSize.SCREEN_WIDTH <= 375 || DeviceType.IS_IPHONE_7PLUS {
            if let items = tabBar.items {
                items.forEach { item in
                    item.imageInsets = UIEdgeInsets(top:-15, left: 0, bottom: -2, right: 0)
                    item.image?.withTintColor(UIColor.white)
                    //                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -0)
                }
            }
            
        }else{
            if let items = tabBar.items {
                items.forEach { item in
                    item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    item.image?.withTintColor(UIColor.white)
                    //                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -0)
                }
            }
        }
        
        
        tabBar.itemWidth = 30.0
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 50
        
    }
    
}
extension RoundedTabBarController{
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        
    }
}
