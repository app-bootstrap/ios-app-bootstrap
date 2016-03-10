//
//  AccountViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit

class PersonalViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Const.PERSONAL
        initView()
    }
    
    func initView() {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .Center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.font = UIFont.systemFontOfSize(24)
        view.addSubview(titleLabel)
        
        let logoutButton = UIButton()
        logoutButton.backgroundColor = Utils.getRGB(Const.COLOR_1)
        logoutButton.setTitle("Logout", forState: UIControlState.Normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.layer.cornerRadius = 2
        logoutButton.addTarget(self, action: Selector("logout:"), forControlEvents: .TouchUpInside)
        logoutButton.titleLabel!.font = UIFont(name: "Helvetica",size: 20)
        view.addSubview(logoutButton)
        let views:Dictionary<String, AnyObject>=["logoutButton": logoutButton, "titleLabel": titleLabel]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[titleLabel(<=20)]-[logoutButton(<=40)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[logoutButton]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
    
    func logout(sender: UIButton) {
        Utils.removeData("login")
        let loginController = LoginViewController()
        navigationController?.presentViewController(loginController, animated: true, completion: nil)
    }
    
    
}

