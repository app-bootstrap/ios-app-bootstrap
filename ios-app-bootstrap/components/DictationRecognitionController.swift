//
//  DictationRecognitionController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 2022/4/27.
//  Copyright © 2022 open source. All rights reserved.
//

import Foundation
import Logger_swift

// https://developer.apple.com/documentation/uikit/uitextinput

class DictationRecognitionController: UIViewController, UITextFieldDelegate {
    let logger = Logger()
    var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        NotificationCenter.default.addObserver(self, selector: #selector(changeInputMode(sender:)), name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
    }

    @objc func changeInputMode(sender: NSNotification) {
        logger.info("changeInputMode:", textField.textInputMode?.primaryLanguage as Any)
    }

    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        view.backgroundColor = UIColor.white

        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(titleLabel)

        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 2
        textField.backgroundColor = Utils.getRGB(Const.COLOR_1)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = UIReturnKeyType.done
        textField.enablesReturnKeyAutomatically = true
        textField.delegate = self

        view.addSubview(textField)
        
        let views:Dictionary<String, AnyObject>=["titleLabel": titleLabel, "textField": textField]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[textField(<=50)]-1-[titleLabel(<=50)]-100-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textField]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
    }
    
}
