//
//  UnitViewModel.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 1/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation

class UnitViewModel {
    // set variable
    private (set) var unitSymbol: String?
    private (set) var unitName: String?
    
    // save the user selected unit
    private (set) var selectUnit: Unit?
    
    /*
     1. init method without parameters
     2. init method - for create normal 'UnitViewModel' object
     */
    init() {
        self.initUnits()
        self.getUnits()
    }
    
    init(unitSymbol:String, unitName:String) {
        self.unitSymbol = unitSymbol
        self.unitName = unitName
    }
    
    // set 'UnitManager' object - for call core data operation
    private let unitManager = UnitManager()
    
    // set 'Unit' array - reference to the 'Unit' data in the core data
    private var units: [Unit]?
    
    // set 'UnitViewModel' array - provide to the picker view controller
    private var unitViewModels: [UnitViewModel]?
    
    // transform the 'Unit' object to 'UnitViewModel' object and add to ‘unitViewModels’ array
    private func getUnitViewModels() -> [UnitViewModel] {
        // use for-each loop get the 'Unit' object, then transform to 'UnitViewModel' object
        for unit in units! {
            let uvm = UnitViewModel(unitSymbol: unit.symbol!, unitName: unit.name!)
            self.unitViewModels!.append(uvm)
        }
        return self.unitViewModels!
    }
    
    // init units
    private func initUnits() {
        unitManager.initUnit()
    }
    
    // get all units
    private func getUnits() {
        // init the array
        self.units = [Unit]()
        self.unitViewModels = [UnitViewModel]()
        
        // set the value to array
        self.units = unitManager.fetchUnit()
        self.unitViewModels = getUnitViewModels()
    }
    
    // get the 'unitViewModels' array count
    func getCount() -> Int {
        return self.unitViewModels!.count
    }
    
    // get item of 'unitViewModels' array
    func getUnitViewModels(index:Int) -> UnitViewModel {
        return self.unitViewModels![index]
    }
    
    // get 'AUD' index, set default unit to 'AUD' and return index
    func getAUD() -> Int {
        var audIndex = 0
        for (index, unit) in units!.enumerated() {
            if(unit.name == "AUD"){
                audIndex = index
            }
        }
        self.setSelectUnit(index: audIndex)
        return audIndex
    }
    
    // set the selected unit object
    func setSelectUnit(index:Int) {
        self.selectUnit = units![index]
    }
}
