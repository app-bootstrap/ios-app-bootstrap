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
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let operationQueue = NSOperationQueue.mainQueue()
        _ = notificationCenter.addObserverForName(UIApplicationDidEnterBackgroundNotification, object: nil, queue: operationQueue, usingBlock: {
            (notification: NSNotification!) in self.logger.info("run in background from Home")
        })
    }
    
    func initView() {
        logger.info("start init view")
        let titleLabel = UILabel()
        titleLabel.textAlignment = .Center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.font = UIFont.systemFontOfSize(24)
        view.addSubview(titleLabel)
        
        let button = UIButton()
        button.backgroundColor = Utils.getRGB(Const.COLOR_1)
        button.setTitle("list", forState: UIControlState.Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 2
        button.titleLabel!.font = UIFont(name: "Helvetica",size: 20)
        button.addTarget(self, action: #selector(HomeViewController.goList(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(button)

        let views:Dictionary<String, AnyObject>=["titleLabel": titleLabel, "button": button]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[titleLabel(<=20)]-[button(<=40)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[button]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
    
    func goList(sender: UIButton) {
        navigationController?.pushViewController(OtherViewController(), animated: true)
    }
}

