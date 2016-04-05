//
//  AccountViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit
import Logger

class PersonalViewController: ViewController , UIGestureRecognizerDelegate {
    let logger = Logger()
    var layer: CAShapeLayer!
    var timer: NSTimer!
    var avatarWidth: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Const.PERSONAL
        initNotification()
        initView()
    }
    
    func initNotification() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let operationQueue = NSOperationQueue.mainQueue()
        _ = notificationCenter.addObserverForName(UIApplicationDidEnterBackgroundNotification, object: nil, queue: operationQueue, usingBlock: {
            (notification: NSNotification!) in self.logger.info("run in background frome Personal")
        })
        //notificationCenter.removeObserver(applicationDidEnterBackgroundObserver)
    }
    
    func initView() {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .Center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.font = UIFont.systemFontOfSize(24)
        view.addSubview(titleLabel)
        
        let avatarFeild = UIView()
        avatarFeild.translatesAutoresizingMaskIntoConstraints = false
        
        let avatar = UIImageView(frame: CGRectMake((view.frame.width - 100) / 2, 30, avatarWidth, avatarWidth))
        avatar.image = UIImage(named: "avatar.png")
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = avatarWidth / 2
        
        avatarFeild.addSubview(avatar)
        
        let path = UIBezierPath(arcCenter: avatar.center, radius: avatarWidth / 2, startAngle: CGFloat(-M_PI / 1.0), endAngle: CGFloat(M_PI / 1.0), clockwise: true)
        
        layer = CAShapeLayer()
        layer.strokeColor = UIColor.blackColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.lineCap = kCALineCapSquare
        layer.path = path.CGPath
        layer.lineWidth = 1.0
        layer.strokeStart = 0.0
        layer.strokeEnd = 0.0
        
        avatarFeild.layer.addSublayer(layer)
        
        startTimer(false)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(PersonalViewController.longPressHandler(_:)))
        longPressGesture.minimumPressDuration = 0.2
        avatarFeild.addGestureRecognizer(longPressGesture)
        
        view.addSubview(avatarFeild)
        
        let logoutButton = UIButton()
        logoutButton.backgroundColor = Utils.getRGB(Const.COLOR_1)
        logoutButton.setTitle("Logout", forState: UIControlState.Normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.layer.cornerRadius = 2
        logoutButton.addTarget(self, action: #selector(PersonalViewController.logout(_:)), forControlEvents: .TouchUpInside)
        logoutButton.titleLabel!.font = UIFont(name: "Helvetica",size: 20)
        view.addSubview(logoutButton)
        let views:Dictionary<String, AnyObject>=["logoutButton": logoutButton, "titleLabel": titleLabel, "avatarFeild": avatarFeild]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[titleLabel(<=20)]-[avatarFeild]-[logoutButton(<=40)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[avatarFeild]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[logoutButton]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
    
    func startTimer(reverse: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(PersonalViewController.updateCircle), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
        timer = nil
    }
    
    func updateCircle() {
        if layer.strokeEnd > 1.0 {
            self.stopTimer()
            return
        }
        layer.strokeEnd += 0.01
    }
    
    func longPressHandler(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .Began {
            stopTimer()
        }
        
        if gestureRecognizer.state == .Ended {
            startTimer(false)
        }
    }
    
    func logout(sender: UIButton) {
        Utils.removeData("login")
        let loginController = LoginViewController()
        navigationController?.presentViewController(loginController, animated: true, completion: nil)
    }
    
}

