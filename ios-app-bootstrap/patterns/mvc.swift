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
    
    func didTapButton(_ button: UIButton) {
        titleLabel.text = "site:\(data.site); github: \(data.githubId)"
    }
    
    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        button.addTarget(self, action: #selector(ViewControllerSample1.didTapButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Utils.getRGB(Const.COLOR_1)
        button.layer.cornerRadius = 2
        button.titleLabel!.font = UIFont(name: "Helvetica",size: 14)
        button.setTitle("Button", for: UIControlState())
        button.setTitleColor(Utils.getRGB(Const.COLOR_3), for: UIControlState())
        view.addSubview(button)
        
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(titleLabel)
        
        let views:Dictionary<String, AnyObject>=["titleLabel": titleLabel, "button": button]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[titleLabel(<=40)]-[button(<=40)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
}
