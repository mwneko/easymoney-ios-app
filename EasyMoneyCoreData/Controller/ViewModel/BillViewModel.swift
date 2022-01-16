//
//  BillViewModel.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 1/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation

class BillViewModel {
    // set variables
    private (set) var title: String?
    private (set) var amount: Double?
    private (set) var type: String?
    private (set) var billDescription: String?
    private (set) var category: String?
    private (set) var subcategory: String?
    private (set) var createAt: String?
    private (set) var unitSymbol: String?
    private (set) var unitName: String?
    private (set) var imageURL: String?
    
    // set the Bill object for edit bill
    private (set) var bill: Bill?
    
    /*
     1. init method without parameters
     2. init method include parameters
     */
    init() {
        self.getBills()
    }
    
    init(title:String, amount:Double, type:String, billDescription:String, category:String, subcategory:String, createAt:String, unitSymbol:String, unitName:String, imageURL:String, bill:Bill) {
        self.title = title
        self.amount = amount
        self.type = type
        self.billDescription = billDescription
        self.category = category
        self.subcategory = subcategory
        self.createAt = createAt
        self.unitSymbol = unitSymbol
        self.unitName = unitName
        self.imageURL = imageURL
        self.bill = bill
    }
    
    // set 'BillManager' object - for call core data operation
    private let billManager = BillManager()
    
    // set 'Bill' array - reference to the 'Bill' data in the core data
    private var bills: [Bill]?
    
    // set 'BillViewModel' array - provide to the master view controller
    private var billViewModels: [BillViewModel]?
    
    // transform the 'Bill' object to 'BillViewModel' object and add to ‘billViewModels’ array
    private func getBillViewModels() -> [BillViewModel] {
        // use for-each loop get the 'Bill' object, then transform to 'BillViewModel' object
        for bill in bills! {
            let bvm = BillViewModel(
                title: bill.title!,
                amount: bill.amount,
                type: bill.type!,
                billDescription: bill.billDescription!,
                category: bill.category!,
                subcategory: bill.subcategory!,
                createAt: DateFormat().dateFormat(date: bill.createAt!),
                unitSymbol: bill.amountUnit!.symbol!,
                unitName: bill.amountUnit!.name!,
                imageURL: "",
                bill: bill
            )
            self.billViewModels!.append(bvm)
        }
        return self.billViewModels!
    }
    
    // get all bills
    private func getBills() {
        // init the array
        self.bills = [Bill]()
        self.billViewModels = [BillViewModel]()
        
        // set the value to array
        self.bills = billManager.fetchBill()
        self.billViewModels = getBillViewModels()
    }
    
    // get the 'billViewModels' array count
    func getCount() -> Int {
        return self.billViewModels!.count
    }
    
    // get item of 'billViewModels' array
    func getBillViewModel(index:Int) -> BillViewModel {
        return self.billViewModels![index]
    }
    
    // add bill
    func addBill(title:String, amount:String, billDescription:String, type:String, category:String, subcategory:String, createAt:Date, amountUnit:Unit) -> Bool {
        // call the add method in the bill manager
        return billManager.addBill(
            title: title,
            amount: Double(amount)!,
            billDescription: billDescription,
            type: type,
            category: category,
            subcategory: subcategory,
            createAt: createAt as NSDate,
            amountUnit: amountUnit
        )
    }
    
    // set the update method
    func updateBill(editItem:Bill, title:String, amount:String, billDescription:String) -> Bool {
        // call the update method in the bill manager
        return billManager.updateBill(
            editItem: editItem,
            title: title,
            amount: Double(amount)!,
            billDescription: billDescription
        )
    }
    
    // delete bill
    func deleteBill(removeBill:Bill) -> Bool {
        // call the delete method in the bill manager
        return billManager.deleteBill(removeBill: removeBill)
    }
    
    // get total spending
    func getTotalSpending() -> Double {
        // create date format
        let dateFormat = DateFormat()
        
        // get current month
        let currentMonth = dateFormat.getCurrentMonth()
        
        // set total spending value
        var totalSpending = 0.0
        
        // get current month toto spending
        for bill in bills! {
            if(dateFormat.dateFormatForSummary(date: bill.createAt!) == currentMonth && bill.type == "Spending"){
                totalSpending += bill.amount
            }
        }
        
        return totalSpending
    }
    
    // get total income
    func getTotalIncome() -> Double {
        // create date format
        let dateFormat = DateFormat()
        
        // get current month
        let currentMonth = dateFormat.getCurrentMonth()
        
        // set total income value
        var totalIncome = 0.0
        
        // get current month toto spending
        for bill in bills! {
            if(dateFormat.dateFormatForSummary(date: bill.createAt!) == currentMonth && bill.type == "Income"){
                totalIncome += bill.amount
            }
        }
        
        return totalIncome
    }
}
