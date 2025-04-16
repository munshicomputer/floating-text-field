//
//  FloatingTextField.swift
//  floating-text-field
//
//  Created by SHAMIM MUNSHI on 17/4/25.
//

import UIKit

protocol FloatingTextFieldDelegate: UITextFieldDelegate {}

class FloatingTextField: UIView, UITextFieldDelegate {
    private let mainView = UIView()
    let textField = UITextField()
    private let placeholderLabel = UILabel()
    private let leftImageView = UIImageView()
    private let rightImageView = UIImageView()
    private let placeholderBackgroundView = UIView()
    
    var isPasswordField: Bool = false {
        didSet {
            configurePasswordField()
            setupConstraints()
            setupView()
        }
    }
    
    // MARK: - Exposed TextField Properties
    var text: String? {
        get { return textField.text }
        set {
            textField.text = newValue
            self.updatePlaceholderPosition()
        }
    }
    
    override var inputView: UIView?{
        get{return textField.inputView}
        set {textField.inputView = newValue}
    }
    
//    override var inputAccessoryView: UIView?{
//        get{return textField.inputAccessoryView ?? nil}
//        set {textField.inputAccessoryView = newValue}
//    }
    
    var textColor: UIColor? {
        get { return textField.textColor }
        set { textField.textColor = newValue }
    }
    
    var font: UIFont? {
        get { return textField.font }
        set { textField.font = newValue }
    }
    
    var textAlignment: NSTextAlignment {
        get { return textField.textAlignment }
        set { textField.textAlignment = newValue }
    }
    
    var keyboardType: UIKeyboardType {
        get { return textField.keyboardType }
        set { textField.keyboardType = newValue }
    }
    
    var isSecureTextEntry: Bool {
        get { return textField.isSecureTextEntry }
        set { textField.isSecureTextEntry = newValue }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType {
        get { return textField.autocapitalizationType }
        set { textField.autocapitalizationType = newValue }
    }
    
    var autocorrectionType: UITextAutocorrectionType {
        get { return textField.autocorrectionType }
        set { textField.autocorrectionType = newValue }
    }
    
    var returnKeyType: UIReturnKeyType {
        get { return textField.returnKeyType }
        set { textField.returnKeyType = newValue }
    }
    
    // MARK: - External Delegate Forwarding
    private weak var externalDelegate: UITextFieldDelegate?
    
    var delegate: UITextFieldDelegate? {
        get { return externalDelegate }
        set {
            externalDelegate = newValue
            textField.delegate = self
        }
    }
    
    var attributedPlaceholder: NSAttributedString? {
        didSet { textField.attributedPlaceholder = attributedPlaceholder }
    }
    
    var borderStyle: UITextField.BorderStyle {
        get { return textField.borderStyle }
        set { textField.borderStyle = newValue }
    }
    
    var placeholderColor: UIColor = .gray
    var titleColor: UIColor = .black
    var borderColor: UIColor = .red
    
    var leftIcon: UIImage? {
        didSet {
            leftImageView.image = leftIcon
            leftImageView.isHidden = (leftIcon == nil)
            updateConstraintsForIcons()
        }
    }
    
    var rightIcon: UIImage? {
        didSet {
            rightImageView.image = rightIcon
            rightImageView.isHidden = (rightIcon == nil && !isPasswordField)
            updateConstraintsForIcons()
        }
    }
    
    var placeholder: String? {
        didSet { placeholderLabel.text = placeholder }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        textField.font = .systemFont(ofSize: 13)
        mainView.layer.borderColor = borderColor.cgColor
        mainView.layer.borderWidth = 1.0
        mainView.layer.cornerRadius = 5
        
        leftImageView.contentMode = .scaleAspectFit
        rightImageView.contentMode = .scaleAspectFit
        leftImageView.tintColor = .gray
        rightImageView.tintColor = .gray
        
        placeholderLabel.textColor = .gray
        placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        placeholderLabel.alpha = 0.7
        
        textField.delegate = self
        textField.borderStyle = .none
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        addSubview(mainView)
        mainView.fillSuperview(padding: .allSides(1))
        
        addSubview(leftImageView)
        addSubview(rightImageView)
        addSubview(textField)
        addSubview(placeholderBackgroundView)
        addSubview(placeholderLabel)
        
        setupConstraints()
        bringSubviewToFront(placeholderLabel)
    }
    
    private func setupConstraints() {
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.deactivate(textField.constraints)
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftIcon == nil ? 8 : 8),
            leftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: leftIcon == nil ? 0 : 20),
            leftImageView.heightAnchor.constraint(equalToConstant: leftIcon == nil ? 0 : 20),
            
            rightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: rightIcon == nil && !isPasswordField ? 16 : -16),
            rightImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightImageView.widthAnchor.constraint(equalToConstant: rightIcon == nil && !isPasswordField ? 0 : 20),
            rightImageView.heightAnchor.constraint(equalToConstant: rightIcon == nil && !isPasswordField ? 0 : 20),
            
            textField.leadingAnchor.constraint(equalTo: leftIcon == nil ? leftImageView.trailingAnchor : leftImageView.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: rightIcon == nil && !isPasswordField ? trailingAnchor : rightImageView.leadingAnchor, constant: -8),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            placeholderBackgroundView.leadingAnchor.constraint(equalTo: placeholderLabel.leadingAnchor, constant: -10),
            placeholderBackgroundView.trailingAnchor.constraint(equalTo: placeholderLabel.trailingAnchor, constant: 10),
            placeholderBackgroundView.centerYAnchor.constraint(equalTo: placeholderLabel.centerYAnchor),
            placeholderBackgroundView.heightAnchor.constraint(equalTo: placeholderLabel.heightAnchor, constant: 6),
            
            placeholderLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
    }
    
    @objc private func textDidChange() {
        updatePlaceholderPosition()
    }
    
    private func updatePlaceholderPosition() {
        UIView.animate(withDuration: 0.3) {
            if self.textField.text?.isEmpty == false {
                self.placeholderLabel.transform = CGAffineTransform(translationX: 10, y: -23)
                self.placeholderBackgroundView.transform = CGAffineTransform(translationX: 10, y: -23)
                self.placeholderLabel.font = .systemFont(ofSize: 12)
                self.placeholderLabel.textColor = self.titleColor
                self.bringSubviewToFront(self.placeholderBackgroundView)
                self.placeholderBackgroundView.backgroundColor = .white
                self.bringSubviewToFront(self.placeholderLabel)
            } else {
                self.placeholderLabel.transform = .identity
                self.placeholderBackgroundView.transform = .identity
                self.placeholderLabel.font = UIFont.systemFont(ofSize: 13)
                self.placeholderLabel.textColor = self.placeholderColor
                self.placeholderBackgroundView.backgroundColor = .clear
            }
        }
    }
    
    private func configurePasswordField() {
        if isPasswordField {
            rightIcon = UIImage(named: "207-eye")?.withRenderingMode(.alwaysTemplate)
            textField.isSecureTextEntry = true
            rightImageView.image = rightIcon
            rightImageView.tintColor = .red
            rightImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility))
            rightImageView.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "207-eye" : "210-eye-blocked"
        rightImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        rightImageView.tintColor = .red
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updatePlaceholderPosition()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatePlaceholderPosition()
    }
    
    private func updateConstraintsForIcons() {
        NSLayoutConstraint.deactivate(leftImageView.constraints)
        NSLayoutConstraint.deactivate(rightImageView.constraints)
        NSLayoutConstraint.deactivate(textField.constraints)
        
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftIcon == nil ? 8 : 8),
            leftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: leftIcon == nil ? 0 : 20),
            leftImageView.heightAnchor.constraint(equalToConstant: leftIcon == nil ? 0 : 20),
            
            rightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: rightIcon == nil && !isPasswordField ? 16 : -16),
            rightImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightImageView.widthAnchor.constraint(equalToConstant: rightIcon == nil && !isPasswordField ? 0 : 20),
            rightImageView.heightAnchor.constraint(equalToConstant: rightIcon == nil && !isPasswordField ? 0 : 20),
            
            textField.leadingAnchor.constraint(equalTo: leftIcon == nil ? leftImageView.trailingAnchor : leftImageView.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: rightIcon == nil && !isPasswordField ? trailingAnchor : rightImageView.leadingAnchor, constant: -8),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - UITextFieldDelegate Forwarding
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return externalDelegate?.textFieldShouldReturn?(textField) ?? true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return externalDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func setInputViewDatePicker(target: Any, selector: Selector, startDate: Date? = nil, endDate: Date? = nil, cancelSelector: Selector? = nil) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        self.inputView = datePicker

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        if let start = startDate {
            datePicker.minimumDate = start
        }

        if let end = endDate {
            datePicker.maximumDate = end
        }

        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: target, action: cancelSelector ?? #selector(self.defaultCancelAction))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolbar.setItems([cancel, flexibleSpace, done], animated: false)
        
        self.textField.inputAccessoryView = toolbar
    }
    
    @objc private func defaultCancelAction() {
        self.textField.resignFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
}
