//
//  mvp.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit

struct Model2 {
    let site: String
    let githubId: String
}

protocol ViewSample2: class {
    func setData(_ data: String)
}

protocol ViewPresenterSample2 {
    init(view: ViewSample2, model: Model2)
    func showData()
}

class PresenterSample2 : ViewPresenterSample2 {
    unowned let view: ViewSample2
    let model: Model2
    
    required init(view: ViewSample2, model: Model2) {
        self.view = view
        self.model = model
    }
    
    func showData() {
        self.view.setData("site:\(self.model.site); github: \(self.model.githubId)")
    }
}

class ViewControllerSample2: UIViewController, ViewSample2 {
    
    var presenter: PresenterSample2!
    let button = UIButton()
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func didTapButton(_ button: UIButton) {
        presenter.showData()
    }
    
    func setData(_ data: String) {
        titleLabel.text = data
    }
    
    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        button.addTarget(self, action: #selector(ViewControllerSample1.didTapButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Utils.getRGB(Const.COLOR_1)
        button.layer.cornerRadius = 2
        button.titleLabel!.font = UIFont(name: "Helvetica",size: 14)
        button.setTitle("Button", for: UIControlState())
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
