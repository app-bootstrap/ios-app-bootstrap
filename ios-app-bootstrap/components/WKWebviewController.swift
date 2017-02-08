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
        let url = URL(string: "https://github.com/xudafeng")
        webview.load(URLRequest(url: url!))
        
        webview.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webview.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        self.view.addSubview(webview)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            logger.info("loading")
        } else if keyPath == "title" {
            self.title = webview.title
        } else if keyPath == "estimatedProgress" {
            logger.info(webview.estimatedProgress)
        }
        
        if !webview.isLoading {
            let javascript = "document.getElementsByTagName('header')[0].style.display = 'none';";
            webview.evaluateJavaScript(javascript) { (_, _) -> Void in
                self.logger.info("javascript loaded")
            }
        }
    }
    
    deinit {
        webview.removeObserver(self, forKeyPath: "loading");
        webview.removeObserver(self, forKeyPath: "title");
        webview.removeObserver(self, forKeyPath: "estimatedProgress");
    }
}
