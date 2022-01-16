//
//  IncomeCategoryViewModel.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 1/10/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import Foundation

class IncomeCategoryViewModel {
    // set variables save the user selected category and subcategory
    private (set) var selectCategory: String? = nil
    private (set) var selectSubcategory: String? = nil
    
    // set 'IncomeCategory' array - for response data
    private var categories = [IncomeCategory]()
    
    // set 'URLSession' - for call rest api
    private let session = URLSession.shared
    
    // set the rest api URL
    private let spendingCategoryURL = "https://yjpihxuk36.execute-api.ap-southeast-2.amazonaws.com/iPhone_SE_Assignment/getincomecategories"
    
    init() {
        self.getCategories()
    }
    
    // call the 'getData' method and refresh the 'categories' data
    private func getCategories() {
        // set the variable to mark the read status
        var readFinish = false
        
        // call the 'getData', when read complete, change the 'readFinish' value
        self.getData(complete: {
            readFinish = true
        })
        
        // if the read data not complete, let the program wait...
        while(!readFinish){}
    }
    
    /*
     get data from rest api
     set the callback function when the api finished the read data
     */
    private func getData(complete: @escaping () -> Void) {
        // set the URL object
        let url = URL(string: spendingCategoryURL)
        
        // set the request
        let request = URLRequest(url: url!)
        
        /*
         1. call the api
         2. catch the error if it existed
         3. get the response data, decoder, transform to the 'SpendingCategory' struct and add to the 'cateigories' array
         */
        let task = session.dataTask(with: request, completionHandler: {
            data, response, downloadError in
            
            if let error = downloadError{
                print(error)
            }else{
                if let dataResponse = data{
                    if let decodeResponse = try? JSONDecoder().decode([IncomeCategory].self, from: dataResponse){
                        for category in decodeResponse {
                            let income = IncomeCategory.init(name: category.name, sub_name: category.sub_name, IC_ID: category.IC_ID)
                            self.categories.append(income)
                        }
                        complete()
                    }
                }
            }
        })
        
        // call the rest api
        task.resume()
    }
    
    // MARK: provide the data to spending controller
    // return the count of array
    func getCount() -> Int {
        return self.categories.count
    }
    
    // return the category
    func getCategory(index:Int) -> String {
        return self.categories[index].name
    }
    
    // return the subcategory
    func getSubcategory(index:Int) -> String {
        return self.categories[index].sub_name
    }
    
    // set the category and subcategory
    func setCategories(category:String?, subcategory:String?) {
        self.selectCategory = category
        self.selectSubcategory = subcategory
    }
}
