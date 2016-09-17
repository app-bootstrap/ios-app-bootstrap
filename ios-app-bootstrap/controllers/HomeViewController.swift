//
//  HomeViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit
import Logger

class HomeViewController: ViewController {
    let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Const.HOME
        initNotification()
        initView()
    }
    
    func initNotification() {
        let notificationCenter = NotificationCenter.default
        let operationQueue = OperationQueue.main
        _ = notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: operationQueue, using: {
            (notification: Notification!) in self.logger.info("run in background from Home")
        })
    }
    
    func initView() {
        logger.info("start init view")
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(titleLabel)
        
        let button = UIButton()
        button.backgroundColor = Utils.getRGB(Const.COLOR_1)
        button.setTitle("list", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 2
        button.titleLabel!.font = UIFont(name: "Helvetica",size: 20)
        button.addTarget(self, action: #selector(HomeViewController.goList(_:)), for: .touchUpInside)
        view.addSubview(button)

        let views:Dictionary<String, AnyObject>=["titleLabel": titleLabel, "button": button]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[titleLabel(<=20)]-[button(<=40)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
    
    func goList(_ sender: UIButton) {
        navigationController?.pushViewController(OtherViewController(), animated: true)
    }
}

