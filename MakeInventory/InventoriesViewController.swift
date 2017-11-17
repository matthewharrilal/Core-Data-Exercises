//
//  ViewController.swift
//  MakeInventory
//
//  Created by Eliel A. Gordon on 11/12/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit
import CoreData

class InventoriesViewController: UIViewController {
    let stack = CoreDataStack.instance
    
    @IBOutlet weak var tableView: UITableView!
    var inventories = [Inventory]()
    var object: Inventory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        stack.saveTo(context: stack.viewContext)
        
        let fetch = NSFetchRequest<Inventory>(entityName: "Inventory")
        do {
            let result = try stack.viewContext.fetch(fetch)
            self.inventories = result
            self.tableView.reloadData()
            
        }catch let error {
            print(error)
        }
    }
}



extension InventoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventories.count
    }
    
}

extension InventoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        
        let item = inventories[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "x\(item.quantity) and the date is \(item.date)"
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var inventory1 = inventories[indexPath.row]
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let addVC = storyboard.instantiateViewController(withIdentifier: "AddInventoryVC") as! AddInventoryViewController
        print(inventory1)
        addVC.managedObject = inventory1
        
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
}