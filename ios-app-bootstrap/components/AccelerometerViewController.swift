//
//  AccelerometerViewController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/25/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Logger
import CoreMotion

class AccelerometerViewController: UIViewController,UIAccelerometerDelegate {
    let logger = Logger()

    var ball:UIImageView!
    var speedX:UIAccelerationValue = 0;
    var speedY:UIAccelerationValue = 0;
    var motionManger = CMMotionManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ball = UIImageView(image:UIImage(named: "avatar.png"));
        ball.frame = CGRect(x: 0, y: 0, width: 50, height: 50);
        ball.center = self.view.center;
        self.view.addSubview(ball);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
