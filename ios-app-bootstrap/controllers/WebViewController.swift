//
//  WebViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/9/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Lottie

class WebviewController: UITabBarController, UIWebViewDelegate, UIViewControllerTransitioningDelegate {
  
  private var _urlString: String
  private var _title: String
  private var _webview = Webview()
  private var _loaded = false
  private var maskView: UIView?
  private var lottieAnimation: LOTAnimationView?
  
  init(urlString: String, title: String, autoLoad: Bool) {
    _urlString = urlString
    _title = title
    super.init(nibName:nil, bundle:nil)
    
    if (autoLoad) {
      startLoad()
    }
    
    let userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent")!;
    let versionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
    UserDefaults.standard.register(defaults: ["UserAgent" : "\(userAgent) custom /\(versionString as! String)"])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
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
    _webview.frame = CGRect(x: 0, y: 65, width: view.bounds.width, height: view.bounds.height - 65 - 50)
    _webview.scalesPageToFit = true
    view.addSubview(_webview)
    _webview.delegate = self
    _webview.scrollView.bounces = false
    
    maskView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
    maskView?.backgroundColor = Utils.getRGB("#ffffff")
    lottieAnimation = LOTAnimationView(name: "static/loading")
    // Set view to full screen, aspectFill
    lottieAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    lottieAnimation!.contentMode = .scaleAspectFill
    lottieAnimation!.frame = view.bounds
    // Add the Animation
    maskView?.addSubview(lottieAnimation!)
    _webview.addSubview(maskView!)
  
    //Play the first portion of the animation on loop until the download finishes.
    lottieAnimation!.loopAnimation = true
    lottieAnimation!.play(fromProgress: 0, toProgress: 0.5, withCompletion: nil)
  }
  
  func _setTitle(_ title: String) {
    navigationItem.title = title
  }
  
  func webViewDidStartLoad(_ webView: UIWebView) {
    lottieAnimation!.pause()
    lottieAnimation!.loopAnimation = true
    lottieAnimation!.frame = CGRect(x: (self.view.frame.width - 100) / 2, y: (self.view.frame.height - 200) / 2, width: 100, height: 100)
    // Speed up animation to finish out the current loop.
    lottieAnimation!.animationSpeed = 2
    lottieAnimation!.play(toProgress: 1)
  }
  
  func webViewDidFinishLoad(_ webView: UIWebView) {
    lottieAnimation?.pause()
    lottieAnimation!.loopAnimation = false
    
    lottieAnimation!.play(toProgress: 1) {[weak self] (_) in
      self!.maskView!.removeFromSuperview()
    }
    
    let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "JSBridge", ofType:"js", inDirectory:"static")!)
    do {
      let javascript = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
      _webview.stringByEvaluatingJavaScript(from: javascript)
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
  
  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    let url = request.mainDocumentURL
    let scheme = request.url?.scheme
    
    let host = url?.host
    let query = url?.query
    
    if (scheme == "jsbridge") {
      
      if (host == "call") {
        var queryStrings = Utils.parseQuery(query!)
        
        let method = queryStrings["method"]
        let data = queryStrings["data"]
        
        if (method == "setTitle") {
          let title = Utils.getValueFromQuery(data!, key: "title")
          _setTitle(title)
        } else if (method == "pushView") {
          let url = Utils.getValueFromQuery(data!, key: "url")
          let title = Utils.getValueFromQuery(data!, key: "title")
          
          if (!url.isEmpty) {
            navigationController?.pushViewController(WebviewController(urlString: url, title: title, autoLoad: true), animated: true)
          }
        } else if (method == "popView") {
          navigationController?.popViewController(animated: true)
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
