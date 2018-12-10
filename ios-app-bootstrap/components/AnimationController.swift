//
//  AnimationController.swift
//  ios-app-bootstrap
//
//  Created by xdf on 3/24/16.
//  Copyright © 2016 open source. All rights reserved.
//

import UIKit
import Logger_swift

class AnimationController: UIViewController {
    let logger = Logger()
    var progressBarView: ProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        view.backgroundColor = UIColor.white
        navigationItem.title = Utils.Path.basename(#file)
        progressBarView = ProgressBarView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        progressBarView.center = view.center
        view.addSubview(progressBarView)
        
        let buttonGroup = UIView()
        buttonGroup.frame = CGRect(x:0, y:view.center.y + 100, width: view.frame.width, height: 40)

        let runButton = UIButton()
        runButton.backgroundColor = Utils.getRGB(Const.COLOR_1)
        runButton.setTitle("run", for: UIControlState())
        runButton.translatesAutoresizingMaskIntoConstraints = false
        runButton.layer.cornerRadius = 2
        runButton.titleLabel!.font = UIFont(name: "Helvetica",size: 12)
        runButton.addTarget(self, action: #selector(AnimationController.runProgress), for: .touchUpInside)
        runButton.setTitleColor(Utils.getRGB(Const.COLOR_3), for: UIControlState())
        buttonGroup.addSubview(runButton)
        
        let resetButton = UIButton()
        resetButton.backgroundColor = Utils.getRGB(Const.COLOR_1)
        resetButton.setTitle("reset", for: UIControlState())
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.layer.cornerRadius = 2
        resetButton.titleLabel!.font = UIFont(name: "Helvetica",size: 12)
        resetButton.addTarget(self, action: #selector(AnimationController.resetProgress), for: .touchUpInside)
        resetButton.setTitleColor(Utils.getRGB(Const.COLOR_3), for: UIControlState())
        buttonGroup.addSubview(resetButton)
        
        let pauseButton = UIButton()
        pauseButton.backgroundColor = Utils.getRGB(Const.COLOR_2)
        pauseButton.setTitle("pause", for: UIControlState())
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.layer.cornerRadius = 2
        pauseButton.titleLabel!.font = UIFont(name: "Helvetica",size: 12)
        pauseButton.addTarget(self, action: #selector(AnimationController.pauseProgress), for: .touchUpInside)
        pauseButton.setTitleColor(Utils.getRGB(Const.COLOR_3), for: UIControlState())
        buttonGroup.addSubview(pauseButton)
        
        let reverseButton = UIButton()
        reverseButton.backgroundColor = Utils.getRGB(Const.COLOR_1)
        reverseButton.setTitle("reverse", for: UIControlState())
        reverseButton.translatesAutoresizingMaskIntoConstraints = false
        reverseButton.layer.cornerRadius = 2
        reverseButton.titleLabel!.font = UIFont(name: "Helvetica",size: 12)
        reverseButton.addTarget(self, action: #selector(AnimationController.reverseProgress), for: .touchUpInside)
        reverseButton.setTitleColor(Utils.getRGB(Const.COLOR_3), for: UIControlState())
        buttonGroup.addSubview(reverseButton)
        
        let views:Dictionary<String, AnyObject>=["runButton": runButton, "resetButton": resetButton, "pauseButton": pauseButton, "reverseButton": reverseButton]
        
        buttonGroup.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[runButton(<=20)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        buttonGroup.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[resetButton(<=20)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        buttonGroup.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[pauseButton(<=20)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        buttonGroup.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[reverseButton(<=20)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        buttonGroup.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[runButton(<=60)]-[resetButton(<=60)]-[pauseButton(<=60)]-[reverseButton(<=60)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        view.addSubview(buttonGroup)
    }
    
    func runProgress() {
        progressBarView.run()
    }
    
    func resetProgress() {
        progressBarView.reset()
    }
    
    func pauseProgress() {
        progressBarView.pause()
    }
    
    func reverseProgress() {
        progressBarView.reverse()
    }
}
