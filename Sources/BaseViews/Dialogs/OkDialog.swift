//
//  OkDialog.swift
//  iOSDepartment
//
//  Created by Александр Строев on 10.09.2021.
//  Copyright © 2021 Stroev. All rights reserved.
//

import UIKit

//Пример кастомного диалога
open class OkDialog: UIView {
    
    lazy public var messageLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        
        view.font = appearance.fonts.regularButtonFontExample
        return view
    }()
    public var shadow: UIView?
    lazy public var okButton: BaseButton = {
        let view = BaseButton()
        view.text = "Ок"
        view.onTap = {
            [weak self] _ in
            self?.remove()
            (self?.okTap ?? { return })()
        
        }
        return view
    }()

    
    public var text: String? {
        get {
            return self.messageLabel.text
        }

        set(text) {
            self.messageLabel.text = text ?? ""
        }
    }

    public var okTap: (()->())?
    
    open func remove(){
        UIView.animate(withDuration: 0.1, animations:  {
            self.shadow?.alpha = 0
            self.alpha = 0
        }, completion: { _ in
        self.removeFromSuperview()
        self.shadow?.removeFromSuperview()
        })
    }
    
    public init(message: String, onOkTap: (()->())?){
        super.init(frame: CGRect())
        addSubview(messageLabel)
        addSubview(okButton)
        messageLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview()
            
        }
        
        okButton.snp.makeConstraints{ make in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(48)
        }
        backgroundColor = appearance.colors.white
        messageLabel.text = message
        layer.cornerRadius = 2
        okTap = onOkTap
    }

    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

