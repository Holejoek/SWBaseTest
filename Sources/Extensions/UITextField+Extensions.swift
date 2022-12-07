//
//  UITextField+Extensions.swift
//  Start
//
//  Created by Иван Тиминский on 30.03.2022.
//

import UIKit

extension UITextField {
    public convenience init(placeholder: String? = nil, fontSize: CGFloat? = nil, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment, shadowColor: UIColor? = nil, cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.init()
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.font = font
        self.textAlignment = textAlignment
        if let placeholder = placeholder {
            self.placeholder = placeholder
        }
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.returnKeyType = .done
    }
}
