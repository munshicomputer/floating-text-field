//
//  ViewController.swift
//  floating-text-field
//
//  Created by SHAMIM MUNSHI on 17/4/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var userNameTF = gFromTF(placeholder: "User Name with left icon", leftIcon: UIImage(named: "ic_user"))
    lazy var passwordTF = gFromTF(placeholder: "Password", leftIcon: UIImage(named: "ic_password"), isPasswordField: true)
    lazy var userNameRightIconTF = gFromTF(placeholder: "User Name with right icon", rightIcon: UIImage(named: "ic_user"))
    lazy var userNameBothIconTF = gFromTF(placeholder: "User Name with both side icon", leftIcon: UIImage(named: "ic_password"), rightIcon: UIImage(named: "ic_user"))
    lazy var simpleTF = gFromTF(placeholder: "Simple Text Field")
    lazy var titleLabel = UILabel(text: "Floating Text Field", font: .systemFont(ofSize: 16, weight: .bold), textColor: .systemRed, textAlignment: .center, numberOfLines: 1)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        [titleLabel, userNameTF, passwordTF, userNameRightIconTF, userNameBothIconTF, simpleTF].forEach { textField in
            textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        }

        let contentStackView = UIStackView(arrangedSubviews: [titleLabel, userNameTF, passwordTF, userNameRightIconTF, userNameBothIconTF, simpleTF])
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

}

