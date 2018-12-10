//
//  mvvm.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit

struct Model3 {
    let site: String
    let githubId: String
}

protocol ViewModelProtocol: class {
    var data: String? {
        get
    }
    var dataDidChange: ((ViewModelProtocol) -> ())? {
        get set
    }
    init(model: Model3)
    func showData()
}

class ViewModelSample3: ViewModelProtocol {
    let model: Model3
    
    var data: String? {
        didSet {
            self.dataDidChange!(self)
        }
    }
    var dataDidChange: ((ViewModelProtocol) -> ())?
    required init(model: Model3) {
        self.model = model
    }
    
    func showData() {
        self.data = "site:\(model.site); github: \(model.githubId)"
    }
}

class ViewControllerSample3: UIViewController {
    
    var viewModel: ViewModelProtocol! {
        didSet {
            self.viewModel.dataDidChange = {[unowned self] viewModel in
                self.titleLabel.text = viewModel.data
            }
        }
    }
    
    let button = UIButton()
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func tapIt() {
        viewModel.showData()
    }
    
    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        button.addTarget(self, action: #selector(ViewControllerSample3.tapIt), for: .touchUpInside)
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
