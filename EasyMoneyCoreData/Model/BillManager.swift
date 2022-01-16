//
//  BillManager.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 24/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BillManager {
    // reference to managed objec context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // add new bill
    func addBill(title:String, amount:Double, billDescription:String, type:String, category:String, subcategory:String, createAt:NSDate, amountUnit:Unit) -> Bool {
        // create new bill object
        let bill = Bill(context: self.context)
        
        // set variable
        bill.title = title
        bill.amount = amount
        bill.billDescription = billDescription
        bill.type = type
        bill.category = category
        bill.subcategory = subcategory
        bill.createAt = createAt
        bill.amountUnit = amountUnit
        
        // save data
        do{
            try self.context.save()
            return true
        }catch{
            print(error.localizedDescription)
            return false
        }
    }
    
    // fetch bill data
    func fetchBill() -> [Bill] {
        // create bills array
        var bills: [Bill]! = nil
        
        do{
            // fetch bill
            bills = try self.context.fetch(Bill.fetchRequest())
            
            // order the array depend on the date desc
            bills.sort(by: { (Bill1, Bill2) -> Bool in
                return Bill1.createAt!.compare(Bill2.createAt! as Date) == .orderedDescending
            })
            
            return bills
        }catch{
            print(error.localizedDescription)
            return bills
        }
    }
    
    // update bill
    func updateBill(editItem:Bill, title:String, amount:Double, billDescription:String) -> Bool {
        // set new value to edit item
        editItem.title = title
        editItem.amount = amount
        editItem.billDescription = billDescription
        
        // save change
        do{
            try self.context.save()
            return true
        }catch{
            print(error.localizedDescription)
            return false
        }
    }
    
    // delete bill
    func deleteBill(removeBill:Bill) -> Bool {
        do{
            // delete bill
            self.context.delete(removeBill)
            
            // save data
            try self.context.save()
            
            return true
        }catch{
            print(error.localizedDescription)
            return false
        }
    }
}
