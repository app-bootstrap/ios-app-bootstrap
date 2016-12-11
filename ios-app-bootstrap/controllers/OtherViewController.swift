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
    let list = ["UIGestureRecognizer", "WKWebview", "Toast", "Animation", "MVC", "MVP", "MVVM","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API","Macaca Test Swipe API"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        navigationItem.title = "list"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        for i in 0 ..< list.count {
            if (i == (indexPath as NSIndexPath).section) {
                cell.textLabel?.text = list[(indexPath as NSIndexPath).section]
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0 ..< list.count {
            if (i == (indexPath as NSIndexPath).section) {
                pushView(list[(indexPath as NSIndexPath).section])
            }
        }
    }
    
    func pushView(_ view: String) {
        logger.info("go view: \(view)")
        var controller: UIViewController
        switch view {
        case "UIGestureRecognizer":
            controller = UIGestureRecognizerViewController()
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
