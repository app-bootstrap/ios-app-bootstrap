//
//  ProgressBarView.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/24/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Logger_swift

class ProgressBarView: UIView {
    let logger = Logger()
    var currentProgress: CGFloat = 0
    var lastProgress: CGFloat = 0
    var timer: Timer!
    var isReverse = false
    var reverseCache = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        initView()
    }
    
    func initView() {
        backgroundColor = UIColor.clear
    }
    
    @objc func update() {
        logger.debug("currentProgress:", currentProgress)
        
        if (currentProgress >= 360 || currentProgress <= -360) {
            reset()
        }
        
        if (currentProgress == 0) {
            
            reverseCache = isReverse
        }

        if (isReverse) {
            currentProgress -= 1
        } else {
            currentProgress += 1
        }
        
        setNeedsDisplay()
    }

    func run() {
        logger.info("process bar run")
        startTimer()
    }
    
    func pause() {
        logger.info("process bar pause")
        stopTimer()
    }
    
    func reset() {
        currentProgress = 0
        logger.info("process bar reset")
    }
    
    func reverse() {
        logger.info("process bar reverse")
        isReverse = !isReverse
    }
    
    func startTimer() {
        if ((timer) != nil) {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(ProgressBarView.update), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if ((timer == nil)) {
            return
        }
        timer.invalidate()
        timer = nil
    }
    
    override func draw(_ rect: CGRect) {
        logger.info("drawRect")
        let lineWidth: CGFloat = 1
        let context = UIGraphicsGetCurrentContext()
        context?.clear(rect)
        context?.saveGState()
        context?.beginPath()
        context?.setStrokeColor(UIColor.blue.cgColor.components!)
        context?.addArc(center: CGPoint(x: self.frame.width / 2 + lineWidth, y: self.frame.height / 2 + lineWidth), radius: self.frame.width / 2 - lineWidth * 2, startAngle: 0, endAngle: CGFloat(currentProgress / 180 * CGFloat(M_PI)), clockwise: reverseCache)
        context?.setLineWidth(lineWidth)
        context?.strokePath()
        context?.restoreGState()
    }
}
