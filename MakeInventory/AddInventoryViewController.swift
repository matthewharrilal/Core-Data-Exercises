//
//  AddInventoryViewController.swift
//  MakeInventory
//
//  Created by Eliel A. Gordon on 11/12/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit
import CoreData

class AddInventoryViewController: UIViewController {
    let coreDataStack = CoreDataStack.instance
    
    @IBOutlet weak var inventoryNameField: UITextField!
    @IBOutlet weak var inventoryQuantityField: UITextField!
    @IBOutlet weak var inventoryDateField: UITextField!
    var managedObject: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("This is the managed object \(managedObject)")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let name = inventoryNameField.text, let quantity = Int64(inventoryQuantityField.text!), let date = inventoryDateField.text else {return}
        
        
        // We are accessing the data from the background queue and in the inventories view controller we essentially are fetching this data from the main queue or the view context
        let inv = Inventory(context: coreDataStack.privateContext)
        
        inv.name = name
        inv.quantity = quantity
        inv.date = date
        
        guard let quantityOfObject = Int(inventoryQuantityField.text!) else {return}
        managedObject?.setValue(quantityOfObject, forKey: "quantity")
        managedObject?.setValue(name, forKey: "name")
        managedObject?.setValue(date, forKey: "date")
        
        
        // We want to save the changes we made to view context or the main queue due to the simple reason that we want to be able to the fact that the user wants to be able to see the changes they made to their inventory item
        coreDataStack.saveTo(context: coreDataStack.viewContext)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func deleteButton(_ sender: Any) {
        let context = coreDataStack.viewContext
        
        
        context.delete(managedObject!)
        do {
            try? context.save()
        }
        self.navigationController?.popViewController(animated: true)
    }
}
