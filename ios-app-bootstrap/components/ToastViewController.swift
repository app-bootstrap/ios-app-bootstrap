//
//  ToastViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/25/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Logger

class ToastViewController: UIViewController {
    let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        view.backgroundColor = UIColor.whiteColor()
        
        let button = UIButton()
        button.backgroundColor = Utils.getRGB(Const.COLOR_1)
        button.setTitle("show", forState: UIControlState.Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 2
        button.titleLabel!.font = UIFont(name: "Helvetica",size: 12)
        button.addTarget(self, action: #selector(ToastViewController.show), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        let views:Dictionary<String, AnyObject>=["button": button]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[button(<=20)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-120-[button]-120-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
    
    func show() {
        view.makeToast(message: "this is toast", duration: 3, position: HRToastPositionCenter)
    }
}