//
//  mvc.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit

struct Model1 {
    let site: String
    let githubId: String
}

class ViewControllerSample1: UIViewController {
    
    var data: Model1!
    let button = UIButton()
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func didTapButton(button: UIButton) {
        titleLabel.text = "site:\(data.site); github: \(data.githubId)"
    }
    
    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        button.addTarget(self, action: #selector(ViewControllerSample1.didTapButton(_:)), forControlEvents: .TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Utils.getRGB(Const.COLOR_1)
        button.layer.cornerRadius = 2
        button.titleLabel!.font = UIFont(name: "Helvetica",size: 14)
        button.setTitle("Button", forState: .Normal)
        view.addSubview(button)
        
        titleLabel.textAlignment = .Center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFontOfSize(18)
        view.addSubview(titleLabel)
        
        let views:Dictionary<String, AnyObject>=["titleLabel": titleLabel, "button": button]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[titleLabel(<=40)]-[button(<=40)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[button]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
}