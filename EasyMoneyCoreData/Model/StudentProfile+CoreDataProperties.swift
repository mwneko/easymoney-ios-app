//
//  StudentProfile+CoreDataProperties.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 8/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//
//

import Foundation
import CoreData


extension StudentProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentProfile> {
        return NSFetchRequest<StudentProfile>(entityName: "StudentProfile")
    }

    @NSManaged public var name: String?
    @NSManaged public var studentNumber: String?
    @NSManaged public var duty: String?
    @NSManaged public var image: NSData?

}
