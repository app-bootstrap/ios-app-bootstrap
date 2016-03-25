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
    let list = ["WKWebview", "Toast", "Animation"]
    
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
        default:
            controller = WKWebviewController()
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}
