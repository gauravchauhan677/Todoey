//
//  ViewController.swift
//  Todoey
//
//  Created by gaurav chauhan on 01/09/19.
//  Copyright © 2019 gaurav chauhan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   
    
   // let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        print(dataFilePath)
        
       
        loadItems()
        

//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
    }
    
    //MARK - Tableview datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
       
        cell.textLabel?.text = item.title
        
        //Ternay Operator
        //value = condition ? valueIfTrue : valurIfFalse
        
        //cell.accessoryType = item.done == true ? .checkmark : .none
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - Tableview delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItem()
        
//       if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//       }else{
//        itemArray[indexPath.row].done = false
//        }
        
        //tableView.reloadData()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //MARK - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add button on UI Alert
           // print("Success!")
           // print(textField.text)
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItem()
            
//            let encoder = PropertyListEncoder()
//            do{
//            let data = try encoder.encode(self.itemArray)
//                try data.write(to : self.dataFilePath!)
//            }catch{
//
//                print("Error encoding items array, \(error)")
//            }
//            //self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
//
//            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            //print(alertTextField.text)
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manipulation Methods
    func saveItem(){
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to : dataFilePath!)
        }catch{
            
            print("Error encoding items array, \(error)")
        }
        //self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(){
       if let data = try? Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
        do{
             itemArray = try decoder.decode([Item].self, from: data)
        }catch{
            print("Error decoding item array, \(error)")
        }
        
        }
        
        
        
    }
    
}

