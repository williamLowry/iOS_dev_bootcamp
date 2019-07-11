//
//  ViewController.swift
//  Todoey
//
//  Created by Will Lowry on 6/19/19.
//  Copyright © 2019 Programmer Alley. All rights reserved.
//

import UIKit
import RealmSwift
//import SwipeCellKit
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {

    var toDoItems: Results<Item>?
    let realm = try! Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedCategory : Category? {
        didSet {
             loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none

    }

    override func viewWillAppear(_ animated: Bool) {
        
        guard let colourHex = selectedCategory?.colour else { fatalError() }
            
        title = selectedCategory?.name
        
        updateNavBar(withHexCode: colourHex)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        updateNavBar(withHexCode: "1D9BF6")
    
    }
    
    
    // MARK: - Navigation Bar Setup Methods
    
    func updateNavBar(withHexCode colourHexCode: String) {
        
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")}
        
        guard let navBarColour = UIColor(hexString: colourHexCode) else { fatalError() }
        
        navBar.barTintColor =  navBarColour
        
        navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
        
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
        
        searchBar.barTintColor = navBarColour
        
        
    }
    
    
    // MARK - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = toDoItems?[indexPath.row] {

            cell.textLabel?.text = item.title
            
            if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(toDoItems!.count)) {
                
                cell.backgroundColor = colour
                
                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
            
            }

            cell.accessoryType = item.done ? .checkmark : .none

        } else {
            cell.textLabel?.text = "No items added"
        }
        
        return cell
    }
    
    
    // MARK - Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row]{
            do {
                try realm.write {
//                    item.done = !item.done
                    realm.delete(item)
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
    
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//
//        performSegue(withIdentifier: "goToItems", sender: self)
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//
//        saveItems()
//
//        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
    // MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            
            self.tableView.reloadData()

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK - Model Manipulation methods
    
    func loadItems(){
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()

    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {

            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
        
    }
}



//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}
