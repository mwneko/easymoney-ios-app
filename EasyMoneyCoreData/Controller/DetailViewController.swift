//
//  DetailViewController.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 22/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // link to view UI
    @IBOutlet weak var billTitle: UITextField!
    @IBOutlet weak var billType: UITextField!
    @IBOutlet weak var billAmountSymbol: UILabel!
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var billAmountName: UILabel!
    @IBOutlet weak var billDescription: UITextView!
    @IBOutlet weak var billDate: UITextField!
    @IBOutlet weak var billCategory: UITextField!
    @IBOutlet weak var billSuncategory: UITextField!
    
    @IBOutlet weak var editOne: UIImageView!
    @IBOutlet weak var editTwo: UIImageView!
    @IBOutlet weak var editThree: UIImageView!
    
    // set the value of UI
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            /*
             1. set the value of each UI
             2. set the UI is readonly
             3. init the UI style
             */
            if let title = billTitle {
                title.isUserInteractionEnabled = false
                title.layer.borderWidth = 1
                title.layer.borderColor = UIColor.white.cgColor
                title.layer.cornerRadius = 4
                title.text = detail.title!
            }
            
            if let type = billType {
                type.isUserInteractionEnabled = false
                type.text = detail.type!
            }
            
            if let amountSymbol = billAmountSymbol{
                amountSymbol.text = detail.unitSymbol!
            }
            
            if let amount = billAmount {
                amount.isUserInteractionEnabled = false
                amount.layer.borderWidth = 1
                amount.layer.borderColor = UIColor.white.cgColor
                amount.layer.cornerRadius = 4
                amount.text = String(detail.amount!)
            }
            
            if let amountName = billAmountName {
                amountName.text = detail.unitName!
            }
            
            if let description = billDescription {
                description.isUserInteractionEnabled = false
                description.layer.borderWidth = 1
                description.layer.borderColor = UIColor.white.cgColor
                description.layer.cornerRadius = 4
                description.text = detail.billDescription!
            }
            
            if let date = billDate {
                date.isUserInteractionEnabled = false
                date.text = detail.createAt!
            }
            
            if let category = billCategory {
                category.isUserInteractionEnabled = false
                category.text = detail.category!
            }
            
            if let subcategory = billSuncategory {
                subcategory.isUserInteractionEnabled = false
                subcategory.text = detail.subcategory!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        
        // set the edit button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(clickEdit))
        
        // when the detailItem is nil, disable the edit button
        if(detailItem == nil){
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }else{
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
        // create two 'UITraitCollection' for landscape and
        let horScreen = UITraitCollection(verticalSizeClass: .compact)
        let verScreen = UITraitCollection(verticalSizeClass: .regular)
        
        /*
         judge when the screen is horizontal, set the heigh trait is compact
         if not, set height trait is regular
         */
        if(UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portrait){
            self.splitViewController?.setOverrideTraitCollection(verScreen, forChild: (self.splitViewController?.viewControllers[0])!)
        }else{
            self.splitViewController?.setOverrideTraitCollection(horScreen, forChild: (self.splitViewController?.viewControllers[0])!)
        }
    }
    
    override func viewLayoutMarginsDidChange() {
        // create two 'UITraitCollection' for landscape and
        let horScreen = UITraitCollection(verticalSizeClass: .compact)
        let verScreen = UITraitCollection(verticalSizeClass: .regular)
        
        /*
         judge when the screen is horizontal, set the heigh trait is compact
         if not, set height trait is regular
         */
        if(UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portrait){
            self.splitViewController?.setOverrideTraitCollection(verScreen, forChild: (self.splitViewController?.viewControllers[0])!)
        }else{
            self.splitViewController?.setOverrideTraitCollection(horScreen, forChild: (self.splitViewController?.viewControllers[0])!)
        }
    }
    
    var detailItem: BillViewModel? {
        didSet {
            configureView()
        }
    }
    
    // the function for click edit button
    @objc func clickEdit(){
        // change button to save
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(clickSave))
        
        /*
         1. set the title, amount, description to can be edit
         2. set the border color to green
         */
        billTitle.isUserInteractionEnabled = true
        billTitle.layer.borderColor = UIColor.green.cgColor
        
        //show the edit icon
        editOne.layer.isHidden = false
        editTwo.layer.isHidden = false
        editThree.layer.isHidden = false
        
        billAmount.isUserInteractionEnabled = true
        billAmount.layer.borderColor = UIColor.green.cgColor
        
        billDescription.isUserInteractionEnabled = true
        billDescription.layer.borderColor = UIColor.green.cgColor
    }
    
    /*
     create a add sumbit check
     1. if bill title or bill amount is empty, return error message
     2. if user does not select bill category, return error message
     3. return success message
     */
    private func submitCheck() -> String {
        if(billTitle.text == ""){
            return SystemMessage.titleError.rawValue
        }else if(billAmount.text == ""){
            return SystemMessage.amountError.rawValue
        }else if(Double(billAmount.text!)! > 9999999){
            return SystemMessage.amountTooLarge.rawValue
        }else{
            return SystemMessage.success.rawValue
        }
    }
    
    // the function for click save button
    @objc func clickSave(){
        // create alert
        let alter: UIAlertController!
        let cancel = UIAlertAction(title: SystemMessage.alertButton.rawValue, style: .default, handler: nil)
        
        // get the 'submitCheck()' result
        let checkResult = submitCheck()
        
        // judgement the 'submitCheck()' result
        if(checkResult == SystemMessage.success.rawValue){
            // call update bill
            let editResult = BillViewModel().updateBill(
                editItem: detailItem!.bill!,
                title: billTitle.text!,
                amount: billAmount.text!,
                billDescription: billDescription.text!
            )
            
            // alert message
            if(editResult){
                // change button to edit
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(clickEdit))
                
                //hide the edit icon
                editOne.layer.isHidden = true
                editTwo.layer.isHidden = true
                editThree.layer.isHidden = true
                
                // if save success, alert success message
                alter = UIAlertController(title: SystemMessage.successTitle.rawValue, message: SystemMessage.updateSuccess.rawValue, preferredStyle: .alert)
                alter.addAction(cancel)
                self.present(alter, animated: true, completion: nil)
                
                // set UI back to read only
                billTitle.isUserInteractionEnabled = false
                billTitle.layer.borderColor = UIColor.white.cgColor
                
                billAmount.isUserInteractionEnabled = false
                billAmount.layer.borderColor = UIColor.white.cgColor
                
                billDescription.isUserInteractionEnabled = false
                billDescription.layer.borderColor = UIColor.white.cgColor
            }else{
                // if faced error, aler error
                alter = UIAlertController(title: SystemMessage.errorTitle.rawValue, message: SystemMessage.updateFailed.rawValue, preferredStyle: .alert)
                alter.addAction(cancel)
                self.present(alter, animated: true, completion: nil)
            }
        }else{
            // alert error message
            alter = UIAlertController(title: SystemMessage.errorTitle.rawValue, message: checkResult, preferredStyle: .alert)
            alter.addAction(cancel)
            self.present(alter, animated: true, completion: nil)
        }
    }
}

