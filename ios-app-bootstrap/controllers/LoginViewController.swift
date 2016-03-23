//
//  LoginViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/9/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Logger

class LoginViewController: ViewController, UITextFieldDelegate {
    let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initView() {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .Center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.font = UIFont.systemFontOfSize(24)
        view.addSubview(titleLabel)
        
        let userNameTextField = UITextField()
        userNameTextField.placeholder = Const.USERNAME_TIPS
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.layer.cornerRadius = 2
        userNameTextField.backgroundColor = Utils.getRGB("#eeffff")
        userNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        userNameTextField.keyboardType = .NumbersAndPunctuation
        userNameTextField.returnKeyType = UIReturnKeyType.Done
        userNameTextField.enablesReturnKeyAutomatically = true
        userNameTextField.delegate = self
        
        view.addSubview(userNameTextField)
        
        let passwordTextField = UITextField()
        passwordTextField.placeholder = Const.PASSWORD_TIPS
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.layer.cornerRadius = 2
        passwordTextField.backgroundColor = Utils.getRGB("#eeffff")
        passwordTextField.secureTextEntry = true
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        passwordTextField.keyboardType = .NumbersAndPunctuation
        passwordTextField.returnKeyType = UIReturnKeyType.Done
        passwordTextField.enablesReturnKeyAutomatically = true
        passwordTextField.delegate = self
        
        view.addSubview(passwordTextField)
        
        let loginButton = UIButton()
        loginButton.backgroundColor = Utils.getRGB(Const.COLOR_1)
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 2
        loginButton.titleLabel!.font = UIFont(name: "Helvetica",size: 20)
        loginButton.addTarget(self, action: #selector(LoginViewController.login(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(loginButton)
        
        let views:Dictionary<String, AnyObject>=["titleLabel": titleLabel, "userNameTextField": userNameTextField, "passwordTextField": passwordTextField, "loginButton": loginButton]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[titleLabel(<=20)]-30-[userNameTextField(<=50)]-10-[passwordTextField(<=50)]-50-[loginButton(<=40)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[userNameTextField]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[passwordTextField]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[loginButton]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
    
    func login(sender: UIButton) {
        logger.info("login")
        Utils.setData("login", value: "login")
        let tabBar = TabBarController()
        navigationController?.presentViewController(tabBar, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}