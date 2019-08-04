//
//  UIGestureRecognizerViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 11/12/2016.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Logger_swift

class UIGestureRecognizerViewController: UIViewController {
    let logger = Logger()
    var rect:UIView!
    var text:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        navigationItem.title = Utils.Path.basename(#file)
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        rect = UIView(frame:CGRect(x:0, y:0, width:150, height:100))
        rect.center = view.center
        rect.backgroundColor = Utils.getRGB(Const.COLOR_1)
        text = UITextView(frame:CGRect(x:0, y:0, width:rect.frame.width, height:rect.frame.height))
        text.text = "haha~"
        text.accessibilityIdentifier = "info"
        text.backgroundColor = UIColor.clear
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .left
        text.textColor = UIColor.white
        rect.addSubview(text)
        view.addSubview(rect)
        bindEvents()
    }
    
    // singleTap/doubleTap/rotate/swipe/longPress/pinch/drag
    func bindEvents() {
        // singleTap
        let tapSingle = UITapGestureRecognizer(target:self,action:#selector(tapSingleDid))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapSingle)
        
        // doubleTap
        let tapDouble = UITapGestureRecognizer(target:self,action:#selector(tapDoubleDid(_:)))
        tapDouble.numberOfTapsRequired = 2
        tapDouble.numberOfTouchesRequired = 1
        tapSingle.require(toFail: tapDouble)
        view.addGestureRecognizer(tapDouble)
        
        // two finger rotation
        let rotation = UIRotationGestureRecognizer(target:self,action:#selector(rotationDid(_:)))
        view.addGestureRecognizer(rotation)
        
        // swipe up down left right
        let swipeUp = UISwipeGestureRecognizer(target:self,action:#selector(swipeDid(_:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        let swipeDown = UISwipeGestureRecognizer(target:self,action:#selector(swipeDid(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        let swipeLeft = UISwipeGestureRecognizer(target:self,action:#selector(swipeDid(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target:self,action:#selector(swipeDid(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        // longPress
        let longPress = UILongPressGestureRecognizer(target:self,action:#selector(longPressDid(_:)))
        view.addGestureRecognizer(longPress)
        
        // pinch
        let pinch = UIPinchGestureRecognizer(target:self,action:#selector(pinchDid(_:)))
        view.addGestureRecognizer(pinch)
        
        // drag(pan)
        let pan = UIPanGestureRecognizer(target:self,action:#selector(panDid(_:)))
        pan.maximumNumberOfTouches = 1
        rect.addGestureRecognizer(pan)
    }
    
    func printInfo(name:String, other:String) {
        text.text = "event: \(name)\n\n\(other)";
    }
    
    @objc func tapSingleDid(_ recognizer:UISwipeGestureRecognizer) {
        let point = recognizer.location(in: view)
        printInfo(name: "singleTap", other: "x:\(point.x) y:\(point.y)")
    }
    
    @objc func tapDoubleDid(_ recognizer:UISwipeGestureRecognizer) {
        let point = recognizer.location(in: view)
        printInfo(name: "doubleTap", other: "x:\(point.x) y:\(point.y)")
    }
    
    @objc func rotationDid(_ recognizer:UIRotationGestureRecognizer) {
        let point = recognizer.location(in: view)
        let rotation = recognizer.rotation * (180 / CGFloat(M_PI))
        printInfo(name: "rotation", other: "x:\(point.x) y:\(point.y)\nrotation:\(rotation)")
    }
    
    @objc func longPressDid(_ recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: view)
        if recognizer.state == .began {
            printInfo(name: "longPress", other: "x:\(point.x) y:\(point.y)\nstate: start")
        } else {
            printInfo(name: "longPress", other: "x:\(point.x) y:\(point.y)\nstate: end")
        }
    }
    
    @objc func pinchDid(_ recognizer:UIPinchGestureRecognizer) {
        let point = recognizer.location(in: view)
        printInfo(name: "pinch", other: "x:\(point.x) y:\(point.y)\nscale: \(recognizer.scale)")
    }
    
    @objc func swipeDid(_ recognizer:UISwipeGestureRecognizer) {
        let point = recognizer.location(in: view)
        var temp:String = ""
        
        if (recognizer.direction == .up) {
            temp = "up"
        } else if (recognizer.direction == .down) {
            temp = "down"
        } else if (recognizer.direction == .left) {
            temp = "left"
        } else if (recognizer.direction == .right) {
            temp = "right"
        }
        printInfo(name: "swipe \(temp)", other: "x:\(point.x) y:\(point.y)\n")
        
    }
    
    @objc func panDid(_ recognizer:UISwipeGestureRecognizer) {
        let point = recognizer.location(in: view)
        rect.center = point
        printInfo(name: "drag", other: "x:\(point.x) y:\(point.y)\n")
    }
}
