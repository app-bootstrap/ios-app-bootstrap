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

class CoreMotionViewController: UIViewController,UIAccelerometerDelegate {
    
    let motionManager = CMMotionManager()
            let titleLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view!.backgroundColor = UIColor.white
        

        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.TITLE
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.frame = view.frame
        view.addSubview(titleLabel)
        
        if !motionManager.isAccelerometerAvailable {
            print("accelerometer is unavailable")
            return
        }

        motionManager.accelerometerUpdateInterval = 0.3
        

        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (accelerometerData, error) in
            if (error != nil) {
                print("accelerometer error：\(error)")
                return
            }
            //print("accelerometer data：\(accelerometerData)")
        }
        

        if !motionManager.isGyroAvailable {
            print("gyro is unavailable")
            return
        }
        motionManager.gyroUpdateInterval = 0.3
        motionManager.startGyroUpdates(to: OperationQueue.main) { (gyroData, error) in
            if (error != nil) {
                print("gyro error：\(error)")
                return
            }
            
            print("gyro data：\(gyroData)")
        }
        
        if !motionManager.isMagnetometerAvailable {
            print("magnetometer")
            return
        }
        motionManager.magnetometerUpdateInterval = 0.3
        motionManager.startMagnetometerUpdates(to: OperationQueue.main) { (magData, error) in
            if error != nil {
                print("magnetometer error:\(error)")
                return
            }
            //print("magnetometer data：\(magData)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
