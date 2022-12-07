//
//  BaseButton.swift
//  iOSDepartment
//
//  Created by Александр Строев on 20.09.2020.
//  Copyright © 2020 Stroev. All rights reserved.
//

import UIKit

open class BaseButton: UIButton {
    
   public var underline: Bool = false {
        didSet {
            let attributedString = NSMutableAttributedString(string:"")
            if underline {
                let attrs = [NSAttributedString.Key.underlineStyle : 1,
                             NSAttributedString.Key.foregroundColor : titleColor(for: .normal) ?? UIColor.black] as [NSAttributedString.Key : Any]
                let buttonTitleStr = NSMutableAttributedString(string: title(for: .normal) ?? "", attributes:attrs)
                attributedString.append(buttonTitleStr)
            }
            setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    public var onTap: ((BaseButton) -> ())? {
        didSet {
            removeTarget(self, action: #selector(onTapHandler), for: .touchUpInside)
            addTarget(self, action: #selector(onTapHandler), for: .touchUpInside)
            isUserInteractionEnabled = true
        }
    }
    
    public var onLongTap: ((BaseButton) -> ())? {
        didSet {
            removeGestureRecognizer(longPressRecognizer)
            addGestureRecognizer(longPressRecognizer)
        }
    }
    
    public var onLongPressed: ((BaseButton) -> ())? {
        didSet {
            removeGestureRecognizer(longPressRecognizer)
            addGestureRecognizer(longPressRecognizer)
        }
    }
    
    public var longPressDuration: CGFloat = 0.5 {
        didSet {
            removeGestureRecognizer(longPressRecognizer)
            addGestureRecognizer(longPressRecognizer)
        }
    }
    
    lazy public var longPressRecognizer: UILongPressGestureRecognizer = {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressedHandler))
        longPressRecognizer.minimumPressDuration = Double(longPressDuration)
        return longPressRecognizer
    }()
    
    @objc private func onTapHandler() {
        onTap?(self)
    }
    
    @objc private func onLongTapHandler() {
        onLongTap?(self)
    }
    
    @objc private func onLongPressedHandler() {
        if longPressRecognizer.state == .ended {
            onLongTap?(self)
        }
        
        if longPressRecognizer.state == .began {
            onLongPressed?(self)
        }
    }
    
    public var text: String {
        set { setTitle(newValue, for: .normal) }
        get { return title(for: .normal) ?? "" }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
