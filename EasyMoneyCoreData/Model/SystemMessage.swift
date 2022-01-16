//
//  SystemMessage.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 8/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation

enum SystemMessage: String {
    // slogan
    case slogan = "Tips: when first time click add button, please wait 3 seconds..."
    
    // alert title
    case errorTitle = "Error"
    case successTitle = "Alert"
    
    // error message
    case titleError = "Please enter bill title."
    case amountError = "Please enter bill amount."
    case categoryError = "Please select a bill category."
    case amountTooLarge = "The amount is too large."
    
    // success message
    case success = "success"
    case addSpendingSuccess = "Add new spending success."
    case addIncomeSuccess = "Add new income success."
    case updateSuccess = "Update bill success."
    
    // failed message
    case addSpendingFailed = "Add new spending Failed."
    case addIncomeFailed = "Add new income Failed."
    case updateFailed = "Update bill Failed."
    
    // alert cancel button
    case alertButton = "OK"
    
    // caerma error message
    case cameraErrorTtitle = "Error accessing media"
    case cameraErrorContent = "Unsupported media source."
}
