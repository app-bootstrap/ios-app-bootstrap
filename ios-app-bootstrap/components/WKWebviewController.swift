//
//  WKWebviewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/23/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import WebKit
import Logger

class WKWebviewController: UIViewController, WKNavigationDelegate {
    var webview: WKWebView!
    let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        
        let userContentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        
        config.userContentController = userContentController
        config.preferences = WKPreferences()
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptEnabled = true
        
        webview = WKWebView(frame: self.view.frame, configuration: config)
        webview.navigationDelegate = self
        let url = NSURL(string: "https://github.com/xudafeng")
        webview.loadRequest(NSURLRequest(URL: url!))
        
        webview.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        webview.addObserver(self, forKeyPath: "title", options: .New, context: nil)
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
        self.view.addSubview(webview)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "loading" {
            logger.info("loading")
        } else if keyPath == "title" {
            self.title = webview.title
        } else if keyPath == "estimatedProgress" {
            logger.info(webview.estimatedProgress)
        }
        
        if !webview.loading {
            let javascript = "document.getElementsByTagName('header')[0].style.display = 'none';";
            webview.evaluateJavaScript(javascript) { (_, _) -> Void in
                self.logger.info("javascript loaded")
            }
        }
    }
}