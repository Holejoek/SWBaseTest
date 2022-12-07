//
//  BaseCollectionCell.swift
//  SWBaseTest
//
//  Created by Иван Тиминский on 06.12.2022.
//

import UIKit

open class BaseCollectionCell: UICollectionViewCell {
    
    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

