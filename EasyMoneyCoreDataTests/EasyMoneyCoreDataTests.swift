//
//  EasyMoneyCoreDataTests.swift
//  EasyMoneyCoreDataTests
//
//  Created by 郭勇 on 22/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import XCTest
@testable import EasyMoneyCoreData

class EasyMoneyCoreDataTests: XCTestCase {
    /*
     the units for testing the basic functions of project
     1. unitManager - fetch unit
     2. profileManager - fetch profile
     3. billManager - fetch bill, add bill, update bill and delete bill
     */
    
    // create test objects
    var unitManager: UnitManager?
    var profileManager: ProfileManager?
    var billManager: BillManager?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // init objects
        unitManager = UnitManager()
        profileManager = ProfileManager()
        billManager = BillManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        unitManager = nil
        profileManager = nil
        billManager = nil
    }
    
    //MARK: test fetch unit
    func testFetchUnit() {
        // get fetch unit result
        let units = unitManager!.fetchUnit()
        
        // the fetch unit method should return 6 items.
        XCTAssertEqual(units.count, 6, "The fetch unit should return 6 items")
    }
    
    //MARK: test fetch profile
    func testFetchProfile() {
        // get fetch unit result
        let profiles = profileManager!.fetchProfiles()
        
        // the fetch profile method should return 3 items
        XCTAssertEqual(profiles.count, 3, "The fetch profile should return 3 items")
    }
    
    //MARK: test fetch bill
    func testFetchBill() {
        // get fetch bill result
        let bills = billManager!.fetchBill()
        
        // the fetch bill method should return 0 or more item
        XCTAssertTrue(bills.count >= 0, "The fetch bill should return 0 or more item")
    }
    
    //MARK: test add bill
    func testAddBill() {
        // get the current fetch bill result count
        let oldCount = billManager!.fetchBill().count
        
        // get a unit object for test add bill
        let unit = unitManager!.fetchUnit()[0]
        
        // get the result of add bill
        let result = billManager!.addBill(
            title: "TestAdd",
            amount: 100.0,
            billDescription: "The bill of testing",
            type: "Spending",
            category: "live",
            subcategory: "shopping",
            createAt: Date() as NSDate,
            amountUnit: unit
        )
        
        // get the new fetch bill result count
        let newCount = billManager!.fetchBill().count
        
        // verify add result
        XCTAssertTrue(result, "The add bill result should be true")
        XCTAssertEqual(newCount, oldCount+1, "The fetch result should add 1 item")
    }
    
    //MARK: test add bill
    func testUpdateBill() {
        // add bill
        self.testAddBill()
        
        // set the new title and amount
        let newTitle = "TestUpdate"
        let newAmount = 200.0
        let newDescription = "Test update bill"
        
        // get the first bill object in the fetch result -- for update
        var bills = billManager!.fetchBill()
        var bill = bills[0]
        
        // get the update result
        let result = billManager!.updateBill(editItem: bill, title: newTitle, amount: newAmount, billDescription: newDescription)
        
        // get the first bill object in the fetch result again -- for verify test result
        bills = billManager!.fetchBill()
        bill = bills[0]
        
        // verify update result
        XCTAssertTrue(result, "The update bill result should be true")
        XCTAssertEqual(bill.title!, newTitle, "The value of bill title should be TestUpdate")
        XCTAssertEqual(bill.amount, newAmount, "The amount should be 200.0")
        XCTAssertEqual(bill.billDescription!, newDescription, "The value of bill description should be Test update bill")
    }
    
    //MARK: test delete bill
    func testDeleteBill() {
        // add bill
        self.testAddBill()
        
        // get the current fetch bill result count
        let oldCount = billManager!.fetchBill().count
        
        // get the first bill object in the fetch result -- for delete
        let bills = billManager!.fetchBill()
        let bill = bills[0]
        
        // get delete result
        let result = billManager!.deleteBill(removeBill: bill)
        
        // get the new fetch bill result count
        let newCount = billManager!.fetchBill().count
        
        // verify add result
        XCTAssertTrue(result, "The add bill result should be true")
        XCTAssertEqual(newCount, oldCount-1, "The fetch result should minus 1 item")
    }
}
