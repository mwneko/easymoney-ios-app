//
//  MasterViewController.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 22/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {
    // create by master-detail template
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    // link to the UI
    @IBOutlet weak var totalSpending: UILabel!
    @IBOutlet weak var totalIncome: UILabel!
    
    // set 'BillViewModel' object
    private var billViewModel = BillViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create by master-detail template
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        // refresh table view data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        // hide the done button
        self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
        self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        
        // set total spending and total income
        totalSpending.text = "\(billViewModel.getTotalSpending())"
        totalIncome.text = "\(billViewModel.getTotalIncome())"
        
        // set when move into split view, must show the master view and detail view
        self.splitViewController?.preferredDisplayMode = .allVisible
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        // refresh table view data
        self.billViewModel = BillViewModel()
        self.tableView.reloadData()
        
        // hide the done button
        self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
        self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        
        // refresh total spending and total income
        totalSpending.text = "\(billViewModel.getTotalSpending())"
        totalIncome.text = "\(billViewModel.getTotalIncome())"
    }
    
    // MARKL: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            // get the index of row
            if let indexPath = tableView.indexPathForSelectedRow {
                // get value from bills array
                let result = billViewModel.getBillViewModel(index: indexPath.row)
                
                // get controller
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                // set the detail item
                controller.detailItem = result
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View
    // set the table column number
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // set the table row number
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billViewModel.getCount()
    }
    
    // set table cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create reuseable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillTableViewCell", for: indexPath) as! BillTableViewCell
        
        // get the 'BillViewModel' object
        let bill = billViewModel.getBillViewModel(index: indexPath.row)
        
        // set attributes
        cell.billTitle.text = bill.title!
        cell.billAmount.text = bill.unitSymbol! + " \(bill.amount!)"
        cell.createAt.text = bill.createAt!
        
        // set bill amount color depend on bill type
        if(bill.type == "Spending"){
            cell.billAmount.textColor = UIColor.red
        }else{
            cell.billAmount.textColor = UIColor.green
        }
        
        // set bill icon depend on bill type
        if(bill.type == "Spending"){
            cell.billIcon.image = UIImage(named: "outcome")
        }else{
            cell.billIcon.image = UIImage(named: "saveMoney")
        }
        
        return cell
    }
    
    // set table row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    // delete item
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: {
            (action, view, completionHandler) in
            // get the remove bill
            let removeBill = self.billViewModel.getBillViewModel(index: indexPath.row).bill!
            
            // remove bill
            let removeResult = self.billViewModel.deleteBill(removeBill: removeBill)
            
            if(removeResult){
                // refresh table view data
                self.billViewModel = BillViewModel()
                self.tableView.reloadData()
                
                // refresh total spending and total income
                self.totalSpending.text = "\(self.billViewModel.getTotalSpending())"
                self.totalIncome.text = "\(self.billViewModel.getTotalIncome())"
            }else{
                print("Remove bill failed")
            }
        })
        
        // return swipe action
        return UISwipeActionsConfiguration(actions: [action])
    }
}

