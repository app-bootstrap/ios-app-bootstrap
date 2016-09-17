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
    var timer: Timer!
    var avatarWidth: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Const.PERSONAL
        initNotification()
        initView()
    }
    
    func initNotification() {
        let notificationCenter = NotificationCenter.default
        let operationQueue = OperationQueue.main
        _ = notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: operationQueue, using: {
            (notification: Notification!) in self.logger.info("run in background frome Personal")
        })
        //notificationCenter.removeObserver(applicationDidEnterBackgroundObserver)
    }
    
    func initView() {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(titleLabel)
        
        let avatarFeild = UIView()
        avatarFeild.translatesAutoresizingMaskIntoConstraints = false
        
        let avatar = UIImageView(frame: CGRect(x: (view.frame.width - 100) / 2, y: 30, width: avatarWidth, height: avatarWidth))
        avatar.image = UIImage(named: "avatar.png")
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = avatarWidth / 2
        
        avatarFeild.addSubview(avatar)
        
        let path = UIBezierPath(arcCenter: avatar.center, radius: avatarWidth / 2, startAngle: CGFloat(-M_PI / 1.0), endAngle: CGFloat(M_PI / 1.0), clockwise: true)
        
        layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = kCALineCapSquare
        layer.path = path.cgPath
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
        logoutButton.setTitle("Logout", for: UIControlState())
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.layer.cornerRadius = 2
        logoutButton.addTarget(self, action: #selector(PersonalViewController.logout(_:)), for: .touchUpInside)
        logoutButton.titleLabel!.font = UIFont(name: "Helvetica",size: 20)
        view.addSubview(logoutButton)
        let views:Dictionary<String, AnyObject>=["logoutButton": logoutButton, "titleLabel": titleLabel, "avatarFeild": avatarFeild]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[titleLabel(<=20)]-[avatarFeild]-[logoutButton(<=40)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[avatarFeild]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[logoutButton]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
    
    func startTimer(_ reverse: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(PersonalViewController.updateCircle), userInfo: nil, repeats: true)
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
    
    func longPressHandler(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            stopTimer()
        }
        
        if gestureRecognizer.state == .ended {
            startTimer(false)
        }
    }
    
    func logout(_ sender: UIButton) {
        Utils.removeData("login")
        let loginController = LoginViewController()
        navigationController?.present(loginController, animated: true, completion: nil)
    }
    
}

