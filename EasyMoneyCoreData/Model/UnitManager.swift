//
//  UnitManager.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 24/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UnitManager {
    // reference to managed objec context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // init the data of unit
    func initUnit() {
        do{
            // query the unit table
            let units : [Unit] = try self.context.fetch(Unit.fetchRequest())
            
            // if unit does not have data, insert init data
            if(units.count == 0){
                // create basic unit
                let aud = Unit(context: self.context)
                aud.name = "AUD"
                aud.symbol = "$"
                
                let usd = Unit(context: self.context)
                usd.name = "USD"
                usd.symbol = "$"
                
                let jpy = Unit(context: self.context)
                jpy.name = "JPY"
                jpy.symbol = "¥"
                
                let rmb = Unit(context: self.context)
                rmb.name = "RMB"
                rmb.symbol = "¥"
                
                let eur = Unit(context: self.context)
                eur.name = "EUR"
                eur.symbol = "€"
                
                let gbp = Unit(context: self.context)
                gbp.name = "GBP"
                gbp.symbol = "￡"
                
                try self.context.save()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // fetch unit data
    func fetchUnit() -> [Unit] {
        // create unit array
        var units: [Unit]! = nil
        
        do{
            // fetch bill
            units = try self.context.fetch(Unit.fetchRequest())
            return units
        }catch{
            print(error.localizedDescription)
            return units
        }
    }
}
