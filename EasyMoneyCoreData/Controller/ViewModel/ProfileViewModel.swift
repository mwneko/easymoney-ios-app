//
//  ProfileViewModel.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 9/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProfileViewModel {
    // set variable
    private (set) var name: String?
    private (set) var studentNumber: String?
    private (set) var duty: String?
    private (set) var image: UIImage?
    
    // set the student profile object for edit image
    private (set) var studentProfile: Profile?
    
    /*
     1. init method without parameters
     2. init method include parameters
     */
    init() {
        self.initProfiles()
        self.getProfiles()
    }
    
    init(name:String, studentNumber:String, duty:String, image:UIImage?, studentProfile:Profile) {
        self.name = name
        self.studentNumber = studentNumber
        self.duty = duty
        self.image = image
        self.studentProfile = studentProfile
    }
    
    // set 'profileManager' object - for call core data operation
    private let profileManager = ProfileManager()
    
    // set 'Profile' array - reference to the 'Profile' data in the core data
    private var profiles: [Profile]?
    
    // set 'StudentProfileViewModel' array - provide to the master view controller
    private var profileViewModels: [ProfileViewModel]?
    
    // init student profile
    private func initProfiles() {
        profileManager.initProflies()
    }
    
    // transform the 'StudentProfile' object to 'StudentProfileViewModel' object and add to ‘StudentProfileViewModels’ array
    private func getProfileViewModels() -> [ProfileViewModel] {
        // use for-each loop get the 'StudentProfile' object, then transform to 'StudentProfileViewModels' object
        for profile in profiles! {
            // create image object
            var profileImage: UIImage?
            
            // if the image in the profile is not nil. transfor to UI image
            if(profile.image != nil){
                profileImage = UIImage(data: profile.image! as Data)
            }
            
            // create new 'ProfileViewModel' object
            let spvm = ProfileViewModel(
                name: profile.name!,
                studentNumber: profile.studentNumber!,
                duty: profile.duty!,
                image: profileImage,
                studentProfile: profile
            )
            
            // add to the array
            self.profileViewModels!.append(spvm)
        }
        return self.profileViewModels!
    }
    
    // get all student profiles
    private func getProfiles() {
        // init the array
        self.profiles = [Profile]()
        self.profileViewModels = [ProfileViewModel]()
        
        // set the value to array
        self.profiles = profileManager.fetchProfiles()
        self.profileViewModels = getProfileViewModels()
    }
    
    // get the 'StudentProfileViewModel' object depend on index
    func getStudentViewModel(index:Int) -> ProfileViewModel {
        return self.profileViewModels![index]
    }
    
    // set image method
    func setImage(editItem:Profile, image:UIImage) {
        profileManager.setImage(editItem: editItem, image: image)
    }
}
