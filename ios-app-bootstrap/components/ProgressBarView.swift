//
//  ProgressBarView.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/24/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Logger

class ProgressBarView: UIView {
    let logger = Logger()
    var currentProgress: CGFloat = 0
    var lastProgress: CGFloat = 0
    var timer: NSTimer!
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
        backgroundColor = UIColor.clearColor()
    }
    
    func update() {
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
        timer = NSTimer.scheduledTimerWithTimeInterval(0.016, target: self, selector: #selector(ProgressBarView.update), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if ((timer == nil)) {
            return
        }
        timer.invalidate()
        timer = nil
    }
    
    override func drawRect(rect: CGRect) {
        logger.info("drawRect")
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, rect)
        CGContextSaveGState(context)
        CGContextBeginPath(context)
        CGContextSetStrokeColor(context, CGColorGetComponents(UIColor.blueColor().CGColor))
        CGContextAddArc(context, self.frame.width / 2, self.frame.height / 2, self.frame.width / 2, 0, CGFloat(currentProgress / 180 * CGFloat(M_PI)), reverseCache ? 1 : 0)
        CGContextSetLineWidth(context, 1)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)
    }
}