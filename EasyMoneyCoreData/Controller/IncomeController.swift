//
//  IncomeController.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 22/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import UIKit

class IncomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    // link to the view UI
    @IBOutlet weak var incomeTitle: UITextField!
    @IBOutlet weak var incomeAmount: UITextField!
    @IBOutlet weak var incomeDescription: UITextView!
    @IBOutlet weak var incomeCollectionView: UICollectionView!
    @IBOutlet weak var unitPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // set the full page button, implement click empty area, hide the keyboard
    @IBAction func hideKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    /*
     1. create 'UnitViewModel' object
     2. create 'SpendingCategoryViewModel' object
     */
    private let unitViewModel = UnitViewModel()
    private let incomeCategoryViewModel = IncomeCategoryViewModel()
    
    // set UICollectionView cell position
    private let spacing : CGFloat = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set collection view data source and delegate
        self.incomeCollectionView.dataSource = self
        self.incomeCollectionView.delegate = self
        
        // set picker view source
        unitPicker.dataSource = self
        unitPicker.delegate = self
        
        // set date picker cannot select futher date
        datePicker.maximumDate = Date()
        
        // refresh unit picker
        DispatchQueue.main.async {
            self.unitPicker.reloadAllComponents()
        }
        
        // set default value to AUD
        unitPicker.selectRow(unitViewModel.getAUD(), inComponent: 0, animated: true)
        
        // set the submit bill button on the right of navigation bar
        self.tabBarController!.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submitIncome))
        
        // clear 'incomeCollectionView' backgroud color
        self.incomeCollectionView.backgroundColor = UIColor.clear
        
        // set 'spendingTitle' delegate
        incomeTitle.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // reload collection view data
        self.incomeCollectionView.reloadData()
        
        // refresh done button
        self.tabBarController!.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submitIncome))
        
        // show the done button
        self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = true
        self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.blue
        
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
    
    // reload the collection view data when the layour margins changed
    override func viewLayoutMarginsDidChange() {
        self.incomeCollectionView.reloadData()
        
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
    
    // when spending title keyboard click 'return', hide the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
     create a add sumbit check
     1. if bill title or bill amount is empty, return error message
     2. if user does not select bill category, return error message
     3. return success message
     */
    private func submitCheck() -> String {
        if(incomeTitle.text == ""){
            return SystemMessage.titleError.rawValue
        }else if(incomeAmount.text == ""){
            return SystemMessage.amountError.rawValue
        }else if(Double(incomeAmount.text!)! > 9999999){
            return SystemMessage.amountTooLarge.rawValue
        }else if(incomeCategoryViewModel.selectCategory == nil){
            return SystemMessage.categoryError.rawValue
        }else{
            return SystemMessage.success.rawValue
        }
    }
    
    // submit function
    @objc func submitIncome(){        
        // hide keyboard
        self.view.endEditing(true)
        
        // create alert
        let alter: UIAlertController!
        let cancel = UIAlertAction(title: SystemMessage.alertButton.rawValue, style: .default, handler: nil)
        
        // get the 'submitCheck()' result
        let checkResult = submitCheck()
        
        // judgement the 'submitCheck()' result
        if(checkResult == SystemMessage.success.rawValue){
            // add new income
            let result = BillViewModel().addBill(
                title: incomeTitle.text!,
                amount: incomeAmount.text!,
                billDescription: incomeDescription.text!,
                type: "Income",
                category: incomeCategoryViewModel.selectCategory!,
                subcategory: incomeCategoryViewModel.selectSubcategory!,
                createAt: datePicker!.date,
                amountUnit: unitViewModel.selectUnit!
            )
            
            // alert message
            if(result){
                // if save success, alert success message
                alter = UIAlertController(title: SystemMessage.successTitle.rawValue, message: SystemMessage.addIncomeSuccess.rawValue, preferredStyle: .alert)
                alter.addAction(cancel)
                self.present(alter, animated: true, completion: nil)
                
                // clean the text field
                incomeTitle.text = ""
                incomeAmount.text = ""
                incomeDescription.text = ""
                
                // reset the description alert
                incomeDescription.text = "Please enter bill description"
                
                // reset the select category and subcategory
                incomeCategoryViewModel.setCategories(category: nil, subcategory: nil)
                
                // reload the data
                self.incomeCollectionView.reloadData()
            }else{
                // if faced error, aler error
                alter = UIAlertController(title: SystemMessage.errorTitle.rawValue, message: SystemMessage.addIncomeFailed.rawValue, preferredStyle: .alert)
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
    
    // MARK: - set UI collection data source
    // set number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return incomeCategoryViewModel.getCount()
    }
    
    // set data source
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // register cell
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "IncomeCell")
        
        // create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IncomeCell", for: indexPath) as! CategoryCell
        
        /*
         get the data from 'SpendingCategoryViewModel'
         set the value to the cell
         */
        cell.categoryLabel.text = incomeCategoryViewModel.getSubcategory(index: indexPath.row)
        cell.categroy = incomeCategoryViewModel.getCategory(index: indexPath.row)
        cell.subcategory = incomeCategoryViewModel.getSubcategory(index: indexPath.row)
        
        // set cell layout
        cell.layer.cornerRadius = 4
        cell.backgroundColor = UIColor.white
        
        cell.categoryLabel.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        
        return cell
    }
    
    // MARK: - set UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // get the cell which has been selected
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        
        // change the cell backgroud color to light gray
        cell.backgroundColor = UIColor.lightGray
        
        // change the local values when the cell be selected
        incomeCategoryViewModel.setCategories(category: cell.categroy, subcategory: cell.subcategory)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // when cell deselect, get the cell and set backgourd color to white
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        cell.backgroundColor = UIColor.white
    }
    
    // MARK: - set UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // init basic spacing
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 10
        
        //Amount of total spacing in a row
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        if let collection = self.incomeCollectionView{
            let width = (collection.bounds.width - totalSpacing) / numberOfItemsPerRow
            return CGSize(width: width, height: 30)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    // MARK: set picker view source
    // set number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // set number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitViewModel.getCount()
    }
    
    // the data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let unit = self.unitViewModel.getUnitViewModels(index: row)
        return unit.unitSymbol! + unit.unitName!
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.unitViewModel.setSelectUnit(index: row)
    }
}
