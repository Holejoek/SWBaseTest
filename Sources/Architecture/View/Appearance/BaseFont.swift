//
//  BaseFont.swift
//  iOSDepartment
//
//  Created by Александр Строев on 10.09.2021.
//  Copyright © 2021 Stroev. All rights reserved.
//

import UIKit

public protocol BaseFontProtocol {
    var name: String { get }
}

extension BaseFontProtocol {
    public func get(_ style: BaseFontStyle = .regular, _ size: CGFloat = 15) -> UIFont {
        return UIFont(name: "\(String(describing: name))\(style.value)", size: size)!
    }
}

public enum BaseFontStyle: String {// можно дополнять по мере необходимости
    case regular, medium, bold, light, black, thin, italic, mediumItalic, boldItalic, lightItalic, blackItalic, thinItalic
    
    public var value: String {
        return rawValue.firstCapitalized
    }
}
