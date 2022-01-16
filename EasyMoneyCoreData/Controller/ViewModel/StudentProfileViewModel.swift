//
//  StudentProfileViewModel.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 8/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StudentProfileViewModel {
    // set variable
    private (set) var name: String?
    private (set) var studentNumber: String?
    private (set) var duty: String?
    private (set) var image: UIImage?
    
    // set the studentProfile object for edit image
    private (set) var studentProfile: StudentProfile?
    
    /*
     1. init method without parameters
     2. init method include parameters
     */
    init() {
        self.initProfiles()
        self.getProfiles()
    }
    
    init(name:String, studentNumber:String, duty:String, image:UIImage?, studentProfile:StudentProfile) {
        self.name = name
        self.studentNumber = studentNumber
        self.duty = duty
        self.image = image
        self.studentProfile = studentProfile
    }
    
    // set 'StudentProfileManager' object - for call core data operation
    private let studentProfileManager = StudentProfileManager()
    
    // set 'StudentProfile' array - reference to the 'Bill' data in the core data
    private var profiles: [StudentProfile]?
    
    // set 'StudentProfileViewModel' array - provide to the master view controller
    private var studentProfileViewModels: [StudentProfileViewModel]?
    
    // transform the 'StudentProfile' object to 'StudentProfileViewModel' object and add to ‘StudentProfileViewModels’ array
    private func getStudentProfileViewModels() -> [StudentProfileViewModel] {
        // use for-each loop get the 'StudentProfile' object, then transform to 'StudentProfileViewModels' object
        for profile in profiles! {
            // create image object
            var profileImage: UIImage?
            
            // if the image in the profile is not nil. transfor to UI image
            if(profile.image != nil){
                profileImage = UIImage(data: profile.image! as Data)
            }
            
            let spvm = StudentProfileViewModel(
                name: profile.name!,
                studentNumber: profile.studentNumber!,
                duty: profile.duty!,
                image: profileImage,
                studentProfile: profile
            )
            self.studentProfileViewModels!.append(spvm)
        }
        return self.studentProfileViewModels!
    }
    
    // get all student profiles
    private func getProfiles() {
        // init the array
        self.profiles = [StudentProfile]()
        self.studentProfileViewModels = [StudentProfileViewModel]()
        
        // set the value to array
        self.profiles = studentProfileManager.fetchProfiles()
        self.studentProfileViewModels = getStudentProfileViewModels()
    }
    
    // get the 'StudentProfileViewModel' object depend on index
    func getStudentViewModel(index:Int) -> StudentProfileViewModel {
        return self.studentProfileViewModels![index]
    }
    
    // set image method
    func setImage(editItem:StudentProfile, image:UIImage) {
        studentProfileManager.setImage(editItem: editItem, image: image)
    }
    
    // init student profile
    private func initProfiles() {
        studentProfileManager.initProflies()
    }
}
