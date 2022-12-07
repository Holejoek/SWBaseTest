//
//  AppearanceFonts.swift
//  iOSDepartment
//
//  Created by Александр Строев on 10.09.2021.
//  Copyright © 2021 Stroev. All rights reserved.
//

import UIKit

public struct AppearanceFonts {
    //Примеры
    let bigLabelFontExample = BaseFont().get(.medium, 24)
    let regularButtonFontExample = BaseFont().get(.black, 18)
    
    let bigLabelFont32 = BaseFont().get(.regular, 32)
    let bigLabelFont24 = BaseFont().get(.regular, 24)
    let subtitleFont16 = BaseFont().get(.regular, 16)
    let textFieldTitleFont14 = BaseFont().get(.regular, 14)
}

open class BaseFont: BaseFontProtocol {
    public var name: String = UIFont.systemFont(ofSize: 15, weight: .regular).fontName
    
    public init() {
        
    }
}
