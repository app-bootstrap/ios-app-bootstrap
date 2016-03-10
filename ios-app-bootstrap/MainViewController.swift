//
//  ViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var alertView:UIAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add lauchscreen image timmer 3s
        NSThread.sleepForTimeInterval(3.0)
        TabBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func aaa() {
        alertView = UIAlertView()
        alertView!.title = "tips"
        alertView!.message = "hello world!"
        alertView!.show()
        self.navigationItem.title = "首页"
        self.parentViewController?.view.window?.backgroundColor = UIColor.blackColor()
    }
    
}

