//
//  AlertViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 16/12/2016.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    func tapped(){
        print("tapped")
    }
    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        view.backgroundColor = UIColor.white
        
        button.backgroundColor = Utils.getRGB(Const.COLOR_1)
        button.setTitle("show", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 2
        button.titleLabel!.font = UIFont(name: "Helvetica",size: 12)
        
        button.addTarget(self, action: #selector(AlertViewController.show(_:)), for: .touchUpInside)
        
        view.addSubview(button)
        
        let views:Dictionary<String, AnyObject>=["button": button]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[button(<=20)]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[button]-120-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        showAlert()
    }
    
    @objc func show(_ sender: UIButton) {
        showAlert()

    }
    
    func showAlert() {
        let alertView = UIAlertView()
        alertView.title = Const.TITLE
        alertView.message = Const.TITLE
        alertView.addButton(withTitle: "no")
        alertView.addButton(withTitle: "yes")
        alertView.cancelButtonIndex = 0
        alertView.show()
    }
}
