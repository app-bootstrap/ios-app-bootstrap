//
//  DictationRecognitionController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 2022/4/27.
//  Copyright © 2022 open source. All rights reserved.
//

import UIKit
import Logger_swift

class DictationRecognitionController: UIViewController {
    let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        view.backgroundColor = UIColor.white
    }
}
