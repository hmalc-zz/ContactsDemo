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
    
    func testEmailEntryUserFlow() {
        
        let exampleEmail = "test@me.ca"
        
        let app = XCUIApplication()
        let firstCell = app.tables.cells.firstMatch
        firstCell.tap()
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.clearText()
        textField.typeText(exampleEmail)
        
        app.navigationBars["Detail"].buttons["Master"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts[exampleEmail].tap()
        
        
    }
    
}

extension XCUIElement {
    func clearText(andReplaceWith newText:String? = nil) {
        tap()
        tap() //When there is some text, its parts can be selected on the first tap, the second tap clears the selection
        press(forDuration: 1.0)
        let selectAll = XCUIApplication().menuItems["Select All"]
        //For empty fields there will be no "Select All", so we need to check
        if selectAll.waitForExistence(timeout: 0.5), selectAll.exists {
            selectAll.tap()
            typeText(String(XCUIKeyboardKey.delete.rawValue))
        }
        if let newVal = newText { typeText(newVal) }
    }
}
