//
//  DateFormatter.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 25/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation

class DateFormat{
    // format the NSDate to String: for show in the view
    func dateFormat(date:NSDate) -> String {
        // create date formatter
        let dateFormat = DateFormatter()
        
        // set the date style
        dateFormat.dateFormat = "dd-MM-yyyy"
        
        return dateFormat.string(from: date as Date)
    }
    
    // get current month
    func getCurrentMonth() -> String {
        // create date formatter
        let dateFormat = DateFormatter()
        
        // set the date style
        dateFormat.dateFormat = "yyyy-MM"
        
        return dateFormat.string(from: Date())
    }
    
    // format the NSDate to String: for summary income and spending
    func dateFormatForSummary(date:NSDate) -> String {
        // create date formatter
        let dateFormat = DateFormatter()
        
        // set the date style
        dateFormat.dateFormat = "yyyy-MM"
        
        return dateFormat.string(from: date as Date)
    }
}
