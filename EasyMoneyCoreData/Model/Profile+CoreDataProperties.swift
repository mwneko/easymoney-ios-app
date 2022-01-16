//
//  Profile+CoreDataProperties.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 9/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var studentNumber: String?
    @NSManaged public var duty: String?
    @NSManaged public var image: NSData?

}
