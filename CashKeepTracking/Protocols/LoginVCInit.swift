//
//  LoginVCInit.swift
//  CashKeepTracking
//
//  Created by Admin on 28.12.2020.
//

import Foundation
import UIKit

protocol LoginViewControllerInit {
    func initLoginVC(_ viewController: UIViewController, _ loginButton: UIButton)
}

extension LoginViewControllerInit {
    func initLoginVC(_ viewController: UIViewController, _ loginButton: UIButton) {
        
        let myColor = UIColor.black
        
        let loginTextField = UITextField()
        let passwordTextField = UITextField()

        loginTextField.frame = CGRect(x: 30, y: 240, width: viewController.view.frame.width - 60, height: 30)
        loginTextField.placeholder = " Enter your login"
        loginTextField.borderStyle = .none
        loginTextField.layer.borderWidth = 0.5
        loginTextField.layer.cornerRadius = 5
        loginTextField.layer.borderColor = myColor.cgColor
        
        passwordTextField.frame = CGRect(x: 30, y: 290, width: viewController.view.frame.width - 60, height: 30)
        passwordTextField.placeholder = " Enter your password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .none
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderColor = myColor.cgColor
        
        loginButton.frame = CGRect(x: viewController.view.center.x - 70, y: 340, width: 140, height: 30)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.alpha = 0.8
        loginButton.layer.cornerRadius = 10
        loginButton.backgroundColor = .black
        
        viewController.view.addSubview(loginTextField)
        viewController.view.addSubview(passwordTextField)
        viewController.view.addSubview(loginButton)
        
        
    }
}
