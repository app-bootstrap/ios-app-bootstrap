//
//  ios_app_bootstrapUITests.swift
//  ios-app-bootstrapUITests
//
//  Created by xdf on 05/11/2017.
//  Copyright © 2017 open source. All rights reserved.
//

import XCTest

class ios_app_bootstrapUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFuncList() {
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        app.buttons["list"].tap()
    }
}
