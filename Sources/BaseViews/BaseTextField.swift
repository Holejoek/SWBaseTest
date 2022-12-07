//
//  BaseTextField.swift
//  SWBaseTest
//
//  Created by Иван Тиминский on 06.12.2022.
//

import UIKit

open class BaseTextField: UITextField {
    var onTextChanged: ((BaseTextField, String) -> ())? {
        didSet {
            addTarget(self, action: #selector(onTextChangedHandler), for: UIControl.Event.editingChanged)
            isUserInteractionEnabled = true
        }
    }
    
    @objc func onTextChangedHandler(textField: UITextField) {
        onTextChanged?(self, text ?? "")
    }
    
    public var textFieldDidBeginEditing: ((BaseTextField, String) -> ())?
    public var textFieldDidEndEditing: ((BaseTextField, String) -> ())?
    public var textFieldDidChangeSelection: ((BaseTextField, String) -> ())?
    
    public var limitOfSymbols: ((Int) -> Bool)?//пока не реализовано
    
    public var nextTextField: UITextField?
    public var onNextTextField: ((UITextField, UITextField, String) -> ())?
    public var onReturn: (() -> ())?
    public var onShouldChangeCharactersIn: ((UITextField, NSRange, String) -> Bool)?
    public var textFieldShouldEndEditing: ((UITextField) -> Bool)?
    public var onDeleteBackward: (() -> ())?
    
    override public init(frame: CGRect = CGRect.zero){
        super.init(frame: frame)
        delegate = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        onDeleteBackward?()
    }
    
    open override func deleteBackward() {
        super.deleteBackward()
        onDeleteBackward?()
    }
}

extension BaseTextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDidBeginEditing?(self, text ?? "")
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidEndEditing?(self, text ?? "")
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldDidChangeSelection?(self, text ?? "")
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onReturn?()
        if let nextField = nextTextField {
            onNextTextField?(self, nextField, text ?? "")
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return onShouldChangeCharactersIn?(textField, range, string) ?? true
    }
    
    public func removeButtonOnKeyboard() {
        inputAccessoryView = nil
    }

    public func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barTintColor = .blue
        doneToolbar.isTranslucent = false
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        done.tintColor = .black

        let items = [flexSpace, done, flexSpace]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        resignFirstResponder()
    }
    
}
