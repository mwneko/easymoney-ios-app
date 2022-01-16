//
//  Bill+CoreDataProperties.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 1/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//
//

import Foundation
import CoreData


extension Bill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bill> {
        return NSFetchRequest<Bill>(entityName: "Bill")
    }

    @NSManaged public var amount: Double
    @NSManaged public var billDescription: String?
    @NSManaged public var category: String?
    @NSManaged public var createAt: NSDate?
    @NSManaged public var subcategory: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var amountUnit: Unit?

}
