//
//  BaseTextView.swift
//  SWBaseTest
//
//  Created by Иван Тиминский on 06.12.2022.
//

import UIKit

open class BaseTextView: UITextView {
    
    open var shouldChangeTextInRange: ((BaseTextView, NSRange, String) -> Bool)?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        textContainer.lineFragmentPadding = 0
        textContainerInset = .zero
    }
    
    override init(frame: CGRect = CGRect.zero, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        
        textContainer?.lineFragmentPadding = 0
        textContainerInset = .zero
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


