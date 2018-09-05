//
//  ShowbieCodingChallengeUITests.swift
//  ShowbieCodingChallengeUITests
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import XCTest

class ShowbieCodingChallengeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .faceUp
        XCUIDevice.shared.orientation = .portrait
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        
        
        
    }
    
}
