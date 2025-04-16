//
//  GlobalFunctions.swift
//  floating-text-field
//
//  Created by SHAMIM MUNSHI on 17/4/25.
//

import Foundation
import UIKit

//MARK: - GLOBAL FUNCTION FOR TEXTFIELD -
func gFromTF( placeholder: String, titleColor: UIColor = .black, borderColor: UIColor = .red, placeholderColor: UIColor = .gray, textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 14), textAlignment: NSTextAlignment = .left, keyboardType: UIKeyboardType = .default, isSecureTextEntry: Bool = false, autocapitalizationType: UITextAutocapitalizationType = .none, autocorrectionType: UITextAutocorrectionType = .no, returnKeyType: UIReturnKeyType = .default, leftIcon: UIImage? = nil, rightIcon: UIImage? = nil, isPasswordField: Bool = false, attributedPlaceholder: NSAttributedString? = nil, borderStyle: UITextField.BorderStyle = .none ) -> FloatingTextField {
    let textField = FloatingTextField()
    textField.placeholder = placeholder
    textField.titleColor = titleColor
    textField.borderColor = borderColor
    textField.placeholderColor = placeholderColor
    textField.textColor = textColor
    textField.font = font
    textField.textAlignment = textAlignment
    textField.keyboardType = keyboardType
    textField.isSecureTextEntry = isSecureTextEntry
    textField.autocapitalizationType = autocapitalizationType
    textField.autocorrectionType = autocorrectionType
    textField.returnKeyType = returnKeyType
    textField.leftIcon = leftIcon
    textField.rightIcon = rightIcon
    textField.isPasswordField = isPasswordField
    textField.attributedPlaceholder = attributedPlaceholder
    textField.borderStyle = borderStyle
    return textField
}
