//
//  SpendingCategory.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 1/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation

// create struct as same as spending category rest api response
struct SpendingCategory: Codable {
    var name: String
    var sub_name: String
    var SC_ID: String
}
