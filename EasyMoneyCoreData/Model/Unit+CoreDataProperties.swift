//
//  Unit+CoreDataProperties.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 23/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//
//

import Foundation
import CoreData


extension Unit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Unit> {
        return NSFetchRequest<Unit>(entityName: "Unit")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var bill: NSSet?

}

// MARK: Generated accessors for bill
extension Unit {

    @objc(addBillObject:)
    @NSManaged public func addToBill(_ value: Bill)

    @objc(removeBillObject:)
    @NSManaged public func removeFromBill(_ value: Bill)

    @objc(addBill:)
    @NSManaged public func addToBill(_ values: NSSet)

    @objc(removeBill:)
    @NSManaged public func removeFromBill(_ values: NSSet)

}
