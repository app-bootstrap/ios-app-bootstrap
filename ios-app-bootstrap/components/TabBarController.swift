//
//  TabBar.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewControllers()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view!.backgroundColor = UIColor.whiteColor()
    }
    
    func initViewControllers() {
        let homeViewController = HomeViewController()
        let personalViewController = PersonalViewController()
        let webViewController = WebviewController(urlString: Const.TEST, title: Const.WEBVIEW, autoLoad: false)
        let testViewController = WebviewController(urlString: Const.TEST_URL, title: Const.TEST_TITLE, autoLoad: false)
        
        let homeNavViewController:UINavigationController = TabBarNavigation(rootViewController: homeViewController)
        let personalNavViewController:UINavigationController = TabBarNavigation(rootViewController: personalViewController)
        let webNavViewController:UINavigationController = TabBarNavigation(rootViewController: webViewController)
        let testNavViewController:UINavigationController = TabBarNavigation(rootViewController: testViewController)
        
        homeNavViewController.tabBarItem = UITabBarItem(title: Const.HOME, image: (Utils.getImgView("tab_home_btn@2x")) , selectedImage: (Utils.getImgView("tab_home_selected_btn@2x")))
        webNavViewController.tabBarItem = UITabBarItem(title: Const.WEBVIEW, image: (Utils.getImgView("tab_web_btn@2x")) , selectedImage: (Utils.getImgView("tab_web_selected_btn@2x")))
        testNavViewController.tabBarItem = UITabBarItem(title: Const.TEST_TITLE, image: (Utils.getImgView("tab_web_btn@2x")) , selectedImage: (Utils.getImgView("tab_web_selected_btn@2x")))
        personalNavViewController.tabBarItem = UITabBarItem(title: Const.PERSONAL, image: (Utils.getImgView("tab_personal_btn@2x")), selectedImage: (Utils.getImgView("tab_personal_selected_btn@2x")))
        
        tabBar.tintColor = Utils.getRGB(Const.COLOR_2)
        viewControllers = [homeNavViewController, webNavViewController, testNavViewController, personalNavViewController]
    }
    
}

class TabBarNavigation: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
