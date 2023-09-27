//
//  WTGLabel.swift
//  Where2Go
//
//  Created by Kiran on 15/08/23.
//

import Foundation
import UIKit

enum FontType: Int {
    
    case regular = 0
    case medium = 1
    case semibold = 2
    case bold = 3
}

@IBDesignable class WTGLabel: UILabel {
    
    @IBInspectable var style: Int = 0 {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var fontSize: CGFloat = 0 {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var fontStyle: Int = 0 {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var applyTitleCase:Bool = false {
        didSet{
            callApplyTitleCase()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateUI()
    }
    
    override func prepareForInterfaceBuilder() {
        updateUI()
    }
    
    func callApplyTitleCase() {
        if applyTitleCase{
            text = text?.capitalized(with: NSLocale.current)
        }
    }
    
    func scaledFontSize(for baseFontSize: CGFloat) -> CGFloat {
        let fontMetrics = UIFontMetrics(forTextStyle: .title1)
        return fontMetrics.scaledValue(for: baseFontSize)
    }
    
    //MARK: GetFontStyle
    func getFontStyle() {

        switch FontType(rawValue: fontStyle) {
            
        case .regular: font = UIFont.WTGfont(.regular, size: fontSize)
            
        case .medium: font = UIFont.WTGfont(.medium, size: fontSize)
            
        case .semibold: font = UIFont.WTGfont(.semibold, size: fontSize)
            
        case .bold: font = UIFont.WTGfont(.bold, size: fontSize)
            
        default: break
            
        }
    }
    
    
    //MARK: LayoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()

        switch style {
            
        case 0: textColor = UIColor.black
        case 1: textColor = UIColor.white
        case 2: textColor = UIColor(named: "dark_blue_color")
        case 3: textColor = UIColor(named: "blue_8968FF")
        case 4: textColor = UIColor(named: "darkblue_001E48")
        case 5: textColor = UIColor(named: "blue_001E48")
        case 6: textColor = UIColor(named: "blue_5135B4")

            
        default: textColor = UIColor.black
            
        }
        
        getFontStyle()
    }
    
    //MARK: UpdateUI
    func updateUI(){

        switch style {
            
        case 0: textColor = UIColor.black
        case 1: textColor = UIColor.white
        case 2: textColor = UIColor(named: "dark_blue_color")
        case 3: textColor = UIColor(named: "blue_8968FF")
        case 4: textColor = UIColor(named: "darkblue_001E48")
        case 5: textColor = UIColor(named: "blue_001E48")
        case 6: textColor = UIColor(named: "blue_5135B4")


        default: textColor = UIColor.black
            
        }
        getFontStyle()
    }

    
}
