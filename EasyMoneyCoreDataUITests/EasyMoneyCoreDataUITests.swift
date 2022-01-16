//
//  EasyMoneyCoreDataUITests.swift
//  EasyMoneyCoreDataUITests
//
//  Created by 郭勇 on 22/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import XCTest

class EasyMoneyCoreDataUITests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Add Spending Test
    func testAddSpendingSuccess(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Add Spending"].tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["shopping"]/*[[".cells.staticTexts[\"shopping\"]",".staticTexts[\"shopping\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Title"].tap()
        
        app.keys["s"].tap()
        app.keys["p"].tap()
        app.keys["e"].tap()
        app.keys["n"].tap()
        app.keys["d"].tap()
        app.keys["i"].tap()
        app.keys["n"].tap()
        app.keys["g"].tap()
        
        app.textFields["Amount"].tap()
        
        app.keys["7"].tap()
        app.keys["0"].tap()

        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "7")
        app.navigationBars["Home"].buttons["Done"].tap()
        
        //XCTAAssert : new spending added
        XCTAssert(app.alerts["Alert"].staticTexts["Add new spending success."].exists)
        
        //Back to home page
        app.alerts["Alert"].buttons["OK"].tap()
        app.tabBars.buttons["Bill"].tap()
        
    }
    
    func testAddSpendingTitleFail(){
        let app = XCUIApplication()
        app.tabBars.buttons["Add Spending"].tap()
        app.navigationBars["Home"].buttons["Done"].tap()
        
        //XCTAAssert : empty title
        XCTAssert(app.alerts["Error"].staticTexts["Please enter bill title."].exists)
        
        //Back to home page
        app.alerts["Error"].buttons["OK"].tap()
        app.tabBars.buttons["Bill"].tap()
    }
    
    func testAddSpendingAmountFail(){
        let app = XCUIApplication()
        app.tabBars.buttons["Add Spending"].tap()
        app.textFields["Title"].tap()
        
        app.keys["s"].tap()
        app.keys["p"].tap()
        app.keys["e"].tap()
        app.keys["n"].tap()
        app.keys["d"].tap()
        app.keys["i"].tap()
        app.keys["n"].tap()
        app.keys["g"].tap()
        
        app.navigationBars["Home"].buttons["Done"].tap()
        
        //XCTAAssert : no category selected
        XCTAssert(app.alerts["Error"].staticTexts["Please enter bill amount."].exists)
        
        //Back to home page
        app.alerts["Error"].buttons["OK"].tap()
        app.tabBars.buttons["Bill"].tap()
    }
    
    func testAddSpendingCategoryFail(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Add Spending"].tap()
        app.textFields["Title"].tap()
        
        app.keys["s"].tap()
        app.keys["p"].tap()
        app.keys["e"].tap()
        app.keys["n"].tap()
        app.keys["d"].tap()
        app.keys["i"].tap()
        app.keys["n"].tap()
        app.keys["g"].tap()
        
        app.textFields["Amount"].tap()
        
        app.keys["7"].tap()
        app.keys["0"].tap()
        
        app.navigationBars["Home"].buttons["Done"].tap()
        
        //XCTAAssert : no category selected
        XCTAssert(app.alerts["Error"].staticTexts["Please select a bill category."].exists)
        
        //Back to home page
        app.alerts["Error"].buttons["OK"].tap()
        app.tabBars.buttons["Bill"].tap()
    }
    
    
    //Add Income Test
    func testAddIncomeSuccess(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Add Income"].tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["salary"]/*[[".cells.staticTexts[\"salary\"]",".staticTexts[\"salary\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Title"].tap()
        
        app.keys["i"].tap()
        app.keys["n"].tap()
        app.keys["c"].tap()
        app.keys["o"].tap()
        app.keys["m"].tap()
        app.keys["e"].tap()
        
        app.textFields["Amount"].tap()
        
        app.keys["2"].tap()
        app.keys["0"].tap()
        app.keys["5"].tap()
        app.keys["3"].tap()
        
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "September")
        app.navigationBars["Home"].buttons["Done"].tap()
        
        //XCTAssertTrue : new income added
        XCTAssert(app.alerts["Alert"].staticTexts["Add new income success."].exists)
        
        //Back to home page
        app.alerts["Alert"].buttons["OK"].tap()
        app.tabBars.buttons["Bill"].tap()
    }
    
    func testAddIncomeTitleFail(){
        let app = XCUIApplication()
        app.tabBars.buttons["Add Income"].tap()
        app.navigationBars["Home"].buttons["Done"].tap()
        
        //XCTAAssert : empty title
        XCTAssert(app.alerts["Error"].staticTexts["Please enter bill title."].exists)
        
        //Back to home page
        app.alerts["Error"].buttons["OK"].tap()
        app.tabBars.buttons["Bill"].tap()
    }
    
    func testAddIncomeAmountFail(){
        let app = XCUIApplication()
        app.tabBars.buttons["Add Income"].tap()
        app.textFields["Title"].tap()
        
        app.keys["i"].tap()
        app.keys["n"].tap()
        app.keys["c"].tap()
        app.keys["o"].tap()
        app.keys["m"].tap()
        app.keys["e"].tap()
        
        app.navigationBars["Home"].buttons["Done"].tap()
        
        //XCTAAssert : no category selected
        XCTAssert(app.alerts["Error"].staticTexts["Please enter bill amount."].exists)
        
        //Back to home page
        app.alerts["Error"].buttons["OK"].tap()
        app.tabBars.buttons["Bill"].tap()
    }
    
    func testAddIncomeCategoryFail(){
        let app = XCUIApplication()
        app.tabBars.buttons["Add Income"].tap()
        app.textFields["Title"].tap()
        
        app.keys["i"].tap()
        app.keys["n"].tap()
        app.keys["c"].tap()
        app.keys["o"].tap()
        app.keys["m"].tap()
        app.keys["e"].tap()
        
        app.textFields["Amount"].tap()
        
        app.keys["1"].tap()
        app.keys["8"].tap()
        app.keys["0"].tap()
        
        app.navigationBars["Home"].buttons["Done"].tap()
        
        //XCTAAssert : no category selected
        XCTAssert(app.alerts["Error"].staticTexts["Please select a bill category."].exists)
        
        //Back to home page
        app.alerts["Error"].buttons["OK"].tap()
        app.tabBars.buttons["Bill"].tap()
    }
    
    //Delete Bill Record Test
    func testDeleteRecord(){
        
        testAddSpendingSuccess()
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 0).swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        
    }
    
    //Update Bill Record Test
    func testUpdateRecordSuccess(){

        testAddSpendingSuccess()
        let app = XCUIApplication()
        app.tables.children(matching: .cell).element(boundBy: 0).tap()
        let detailNavigationBar = app.navigationBars["Detail"]
        detailNavigationBar.buttons["Edit"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element

        element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .textField).element.tap()
        
        app.keys["u"].tap()
        app.keys["p"].tap()
        app.keys["d"].tap()
        app.keys["a"].tap()
        app.keys["t"].tap()
        app.keys["e"].tap()
        
        element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .textField).element.tap()
        
        app.keys["Delete"].press(forDuration: 2.0);
        
        app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        element.children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .textView).element.tap()
        
        app.keys["u"].tap()
        app.keys["p"].tap()
        app.keys["d"].tap()
        app.keys["a"].tap()
        app.keys["t"].tap()
        app.keys["e"].tap()
        
        app.keys["space"].tap()
        
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        
        app.keys["space"].tap()
        
        detailNavigationBar.buttons["Save"].tap()
        
        //XCTAssertTrue : bill update
        XCTAssert(app.alerts["Alert"].staticTexts["Update bill success."].exists)
        
        app.alerts["Alert"].buttons["OK"].tap()
    }
    
    //Profile Test
    func testProfile(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Profile"].tap()
        
    }
}
