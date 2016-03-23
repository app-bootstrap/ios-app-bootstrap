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
        initView()
    }
    
    func initView() {
        logger.info("start init view")
        let titleLabel = UILabel()
        titleLabel.textAlignment = .Center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.font = UIFont.systemFontOfSize(24)
        view.addSubview(titleLabel)

        let views:Dictionary<String, AnyObject>=["titleLabel": titleLabel]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[titleLabel(<=20)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
}

