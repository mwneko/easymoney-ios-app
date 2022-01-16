//
//  StudentProfileManager.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 8/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StudentProfileManager {
    // reference to managed objec context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // init profies
    func initProflies() {
        do{
            // query the studentProfile table
            let profiles : [StudentProfile] = try self.context.fetch(StudentProfile.fetchRequest())
                        
            // if profile does not have data, insert init data
            if(profiles.count == 0){
                let studentOne = StudentProfile(context: self.context)
                studentOne.name = "Yong Guo"
                studentOne.studentNumber = "s3699534"
                studentOne.duty = "Back-end Developer"
                studentOne.image = nil
                
                let studentTwo = StudentProfile(context: self.context)
                studentTwo.name = "Qiaochu Wang"
                studentTwo.studentNumber = "s3699777"
                studentTwo.duty = "Front-end Developer"
                studentTwo.image = nil
                
                let studentThree = StudentProfile(context: self.context)
                studentThree.name = "Bowen Lu"
                studentThree.studentNumber = "s3765724"
                studentThree.duty = "Tester & Cocoa"
                studentThree.image = nil
                
                try self.context.save()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // fetch studentProfile data
    func fetchProfiles() -> [StudentProfile] {
        // create studentProfile array
        var profiles: [StudentProfile]! = nil
        
        do{
            // fetch bill
            profiles = try self.context.fetch(StudentProfile.fetchRequest())
            return profiles
        }catch{
            print(error.localizedDescription)
            return profiles
        }
    }
    
    // set the image
    func setImage(editItem:StudentProfile, image:UIImage) -> Bool {
        // set new image
        editItem.image = image.pngData()! as NSData
        
        do{
            try self.context.save()
            return true
        }catch{
            print(error.localizedDescription)
            return false
        }
    }
}
