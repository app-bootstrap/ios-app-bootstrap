//
//  LoginViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/9/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Logger_swift

class LoginViewController: ViewController, UITextFieldDelegate {
    let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView();
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initView() {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(titleLabel)
        
        let userNameTextField = UITextField()
        userNameTextField.placeholder = Const.USERNAME_TIPS
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.layer.cornerRadius = 2
        userNameTextField.backgroundColor = Utils.getRGB("#eeffff")
        userNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        userNameTextField.keyboardType = .numbersAndPunctuation
        userNameTextField.returnKeyType = UIReturnKeyType.done
        userNameTextField.enablesReturnKeyAutomatically = true
        userNameTextField.delegate = self
        
        view.addSubview(userNameTextField)
        
        let passwordTextField = UITextField()
        passwordTextField.placeholder = Const.PASSWORD_TIPS
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.layer.cornerRadius = 2
        passwordTextField.backgroundColor = Utils.getRGB("#eeffff")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        passwordTextField.keyboardType = .numbersAndPunctuation
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.enablesReturnKeyAutomatically = true
        passwordTextField.delegate = self
        
        view.addSubview(passwordTextField)
        
        let loginButton = UIButton()
        loginButton.backgroundColor = Utils.getRGB(Const.COLOR_1)
        loginButton.setTitle("Login", for: UIControl.State())
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 2
        loginButton.titleLabel!.font = UIFont(name: "Helvetica",size: 20)
        loginButton.addTarget(self, action: #selector(LoginViewController.login(_:)), for: .touchUpInside)
        view.addSubview(loginButton)
        
        let views:Dictionary<String, AnyObject>=["titleLabel": titleLabel, "userNameTextField": userNameTextField, "passwordTextField": passwordTextField, "loginButton": loginButton]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[titleLabel(<=20)]-30-[userNameTextField(<=50)]-10-[passwordTextField(<=50)]-50-[loginButton(<=40)]-100-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[userNameTextField]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[passwordTextField]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[loginButton]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
    }
    
    @objc func login(_ sender: UIButton) {
        logger.info("login")
        Utils.setData("login", value: "login")
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
