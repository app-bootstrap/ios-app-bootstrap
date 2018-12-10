//
//  DataHubViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 05/02/2018.
//  Copyright © 2018 open source. All rights reserved.
//

import UIKit
import Logger_swift
import Alamofire

class DataHubViewController: UIViewController {
  let logger = Logger()
  let textView = UITextView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  func initView() {
    navigationItem.title = Utils.Path.basename(#file)
    view.backgroundColor = UIColor.white
    
    let button = UIButton()
    button.backgroundColor = Utils.getRGB(Const.COLOR_1)
    button.setTitle("request", for: UIControlState())
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 2
    button.titleLabel!.font = UIFont(name: "Helvetica",size: 16)
    button.addTarget(self, action: #selector(DataHubViewController.doRequest(_:)), for: .touchUpInside)
    button.setTitleColor(Utils.getRGB(Const.COLOR_3), for: UIControlState())
    view.addSubview(button)
    
    let switchbutton = UIButton()
    switchbutton.backgroundColor = Utils.getRGB(Const.COLOR_1)
    switchbutton.setTitle("swich scene", for: UIControlState())
    switchbutton.translatesAutoresizingMaskIntoConstraints = false
    switchbutton.layer.cornerRadius = 2
    switchbutton.titleLabel!.font = UIFont(name: "Helvetica",size: 16)
    switchbutton.addTarget(self, action: #selector(DataHubViewController.switchDataHubScene(_:)), for: .touchUpInside)
    switchbutton.setTitleColor(Utils.getRGB(Const.COLOR_3), for: UIControlState())
    view.addSubview(switchbutton)
    
    textView.text = ""
    textView.backgroundColor = UIColor.lightGray
    textView.textAlignment = .left
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = UIFont.systemFont(ofSize: 12)
    view.addSubview(textView)
    
    let views:Dictionary<String, AnyObject>=[
      "textView": textView,
      "button": button,
      "switchbutton": switchbutton
    ]
    
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[button(<=30)]-10-[switchbutton(<=30)]-10-[textView(<=200)]-300-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textView]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[button]-120-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[switchbutton]-120-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
  }
  
  func doRequest(_ sender: UIButton) {
    let parameters: Parameters = [
      "foo": "bar"
    ]
    Alamofire
      .request(Utils.dataHubAdapter("testApi"), method: .post, parameters: parameters, encoding: URLEncoding.default)
      .responseJSON { response in
        debugPrint(response)
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
          self.textView.text = "result:\n\(utf8Text)"
        }
      }
  }

  func switchDataHubScene(_ sender: UIButton) {
    
    // TODO switch scene
  }
}
