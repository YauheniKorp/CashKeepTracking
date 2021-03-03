//
//  ViewController.swift
//  CashKeepTracking
//
//  Created by Admin on 28.12.2020.
//

import UIKit

class ViewController: UIViewController, LoginViewControllerInit {
    
    var loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(goToAnotherVC), for: .touchUpInside)
        initLoginVC(self, loginButton)
        
    }
    
    @objc func goToAnotherVC() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "App") else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}

