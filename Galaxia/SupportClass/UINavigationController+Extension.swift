//
//  UINavigationController+Extension.swift
//  Where2Go
//
//  Created by Kiran on 15/08/23.
//

import Foundation
import UIKit

extension UINavigationController {
    
    public func goBack(animated: Bool = true){
        self.popViewController(animated: animated)
    }
    
       open override var preferredStatusBarStyle: UIStatusBarStyle {
          return topViewController?.preferredStatusBarStyle ?? .lightContent
       }
        
}

class RootVC: UINavigationController{
    
    public func GetRootVC()->UINavigationController{
        
        let storyboard = RoundedTabBarController.instantiate(fromAppStoryboard: .Main)
        let rootNC = UINavigationController(rootViewController: storyboard)
        storyboard.navigationController?.navigationBar.isHidden = true
        return rootNC
     
        
    }
    
    
}

extension UIView{
    
    func setGradientBackground(view: UIView, colors: [UIColor]) {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // Convert UIColors to CGColors
        let cgColors = colors.map { $0.cgColor }
        
        // Set the colors for the gradient (you can customize this as needed)
        gradientLayer.colors = cgColors
        
        // You can specify the locations for the colors (optional)
        // gradientLayer.locations = [0.0, 1.0]
        
        // You can specify the start and end points of the gradient (optional)
        // gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        // gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        // Add the gradient layer as a sublayer
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
