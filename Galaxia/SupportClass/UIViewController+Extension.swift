//
//  UIViewController+Extension.swift
//  Where2Go
//
//  Created by Kiran on 15/08/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
extension UICollectionView {

 func scrollToNextItem() {
    let contentOffset = CGFloat(floor(self.contentOffset.x +
    self.bounds.size.width))
    self.moveToFrame(contentOffset: contentOffset)
}

func scrollToPreviousItem() {
    let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
    self.moveToFrame(contentOffset: contentOffset)
}

func moveToFrame(contentOffset : CGFloat) {
    self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
}}


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
