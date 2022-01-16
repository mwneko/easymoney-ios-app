//
//  IncomeCategory.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 1/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation

// create struct as same as income category rest api response
struct IncomeCategory: Codable {
    var name: String
    var sub_name: String
    var IC_ID: String
}
