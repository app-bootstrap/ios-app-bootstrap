//
//  OtherViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/23/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Logger

class OtherViewController: UITableViewController {
    let logger = Logger()
    let list = ["WKWebview", "Toast", "Animation", "MVC", "MVP", "MVVM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        navigationItem.title = "list"
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        for i in 0 ..< list.count {
            if (i == indexPath.section) {
                cell.textLabel?.text = list[indexPath.section]
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        for i in 0 ..< list.count {
            if (i == indexPath.section) {
                pushView(list[indexPath.section])
            }
        }
    }
    
    func pushView(view: String) {
        logger.info("go view: \(view)")
        var controller: UIViewController
        switch view {
        case "WKWebview":
            controller = WKWebviewController()
        case "Animation":
            controller = AnimationController()
        case "Toast":
            controller = ToastViewController()
        case "MVC":
            let model = Model1(site: "xdf.me", githubId: "xudafeng")
            let view = ViewControllerSample1()
            view.data = model
            controller = view
        case "MVP":
            let model = Model2(site: "xdf.me", githubId: "xudafeng")
            let view = ViewControllerSample2()
            let presenter = PresenterSample2(view: view, model: model)
            view.presenter = presenter
            controller = view
        case "MVVM":
            let model = Model3(site: "xdf.me", githubId: "xudafeng")
            let viewModel = ViewModelSample3(model: model)
            let view = ViewControllerSample3()
            view.viewModel = viewModel
            controller = view
        default:
            controller = WKWebviewController()
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}
