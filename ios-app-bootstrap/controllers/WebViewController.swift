//
//  WebViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/9/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit

class WebviewController: UITabBarController, UIWebViewDelegate {
    
    var _urlString: String
    var _title: String
    var _webview = Webview()
    var _loaded = false
    
    init(urlString: String, title: String, autoLoad: Bool) {
        _urlString = urlString
        _title = title
        super.init(nibName:nil, bundle:nil)
        
        if (autoLoad) {
            startLoad()
        }
        
        var userAgent = UIWebView().stringByEvaluatingJavaScriptFromString("navigator.userAgent")!;
        userAgent += " xdf"
        let versionString = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")!
        userAgent += "/" + (versionString as! String)
        NSUserDefaults.standardUserDefaults().registerDefaults(["UserAgent" : userAgent])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        startLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setTitle(_title)
        initView()
    }
    
    func startLoad() {
        if (!_loaded) {
            _webview.loadURL(_urlString)
            _loaded = true
        }
    }
    
    func initView() {
        _webview.frame = CGRectMake(0, 65, view.bounds.width, view.bounds.height - 65 - 50)
        _webview.scalesPageToFit = true
        view.addSubview(_webview)
        _webview.delegate = self
        _webview.scrollView.bounces = false
    }
    
    func _setTitle(title: String) {
        navigationItem.title = title
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let fileURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("JSBridge", ofType:"js", inDirectory:"static")!)
        do {
            let javascript = try String(contentsOfURL: fileURL, encoding: NSUTF8StringEncoding)
            _webview.stringByEvaluatingJavaScriptFromString(javascript)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.mainDocumentURL
        let scheme = request.URL?.scheme
        
        let host = url?.host
        let query = url?.query
        
        if (scheme == "jsbridge") {
            
            if (host == "call") {
                
                var queryStrings = Utils.parseQuery(query!)
                
                let method = queryStrings["method"]
                
                if (method == "setTitle") {
                    
                    let title = Utils.getValueFromQueue(queryStrings, key: "title")
                    _setTitle(title)
                } else if (method == "pushView") {
                    let url = Utils.getValueFromQueue(queryStrings, key: "url")
                    let title = Utils.getValueFromQueue(queryStrings, key: "title")
                    
                    if (!url.isEmpty) {
                        navigationController?.pushViewController(WebviewController(urlString: url, title: title, autoLoad: true), animated: true)
                    }
                } else if (method == "popView") {
                    navigationController?.popViewControllerAnimated(true)
                }
            } else if (host == "dispatch") {
                
            } else {
                
            }
            return false
        } else {
            return true
        }
    }
}
