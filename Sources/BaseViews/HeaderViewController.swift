//
//  HeaderViewController.swift
//  iOSDepartment
//
//  Created by Александр Строев on 10.09.2021.
//  Copyright © 2021 Stroev. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

open class HeaderViewController: UIView {
    private var buttonWidth: CGFloat = 40.0
    
    private var leftButtons: [UIButton] = []
    private var rightButtons: [UIButton] = []
    
    lazy public var titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    private lazy var leftStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    private lazy var rightStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        addConstr()
    }
    
    private func setupSubviews(){
        addSubview(titleLabel)
        addSubview(leftStack)
        addSubview(rightStack)
    }
    
    public var height: CGFloat = 0 {
        didSet {
            snp.remakeConstraints{ make in
                make.left.right.equalToSuperview()
                make.top.equalTo(superview?.safeAreaLayoutGuide.snp.top ?? 0.0 )
                make.height.equalTo(height)
            }
        }
    }
    
    public var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    @discardableResult
    open func addButton(image: UIImage, type: ButtonAlignment, onTap: ((BaseButton)->())? = nil) -> BaseButton {
        
        let button = BaseButton()
        button.isHidden = false
        button.setImage(image, for: .normal)
        button.onTap = onTap
        switch type {
            case .left:
                leftButtons.append(button)
                leftStack.addArrangedSubview(button)
            case .right:
                rightButtons.append(button)
                rightStack.addArrangedSubview(button)
            }
        button.snp.makeConstraints{ make in
            make.width.equalTo(buttonWidth)
            make.height.equalToSuperview()
        }
        return button
    }
    
    private func addConstr(){
        titleLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.left.equalTo(leftStack.snp.right)
            make.right.equalTo(rightStack.snp.left)
            make.top.bottom.equalToSuperview()
        }
        leftStack.snp.makeConstraints{ make in
            make.left.top.bottom.equalToSuperview()
        }
        rightStack.snp.makeConstraints{ make in
            make.right.top.bottom.equalToSuperview()
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public enum ButtonAlignment {
        case left, right
    }
    
}



