//
//  Webview.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit

class Webview: UIWebView {
    
    func loadURL(_ urlString: String) {
        var url: URL
        
        if (urlString == Const.TEST) {
            url = URL(fileURLWithPath:Bundle.main.path(forResource: "test", ofType:"html" , inDirectory:"static")!)
        } else {
            url = URL(string: urlString)!
        }
        
        let request = URLRequest(url: url)
        
        super.loadRequest(request)
    }
}
