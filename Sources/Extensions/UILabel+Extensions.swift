//
//  UILabel+Extensions.swift
//  Start
//
//  Created by Иван Тиминский on 28.03.2022.
//

import UIKit

extension UILabel {
    
    public convenience init(text: String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment, numberOfLines: Int) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    
    public convenience init(text: String, fontSize: CGFloat, fontName: String, textColor: UIColor, textAlignment: NSTextAlignment, numberOfLines: Int) {
        self.init()
        self.text = text
        self.font = .init(name: fontName, size: fontSize)
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
