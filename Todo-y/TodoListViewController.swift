//
//  ViewController.swift
//  Todo-y
//
//  Created by Benjamin, Matthew on 4/11/19.
//  Copyright © 2019 Benjamin, Matthew. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray : [String] = []
    let defaults = UserDefaults.standard
    let DEFAULTS_KEY = "TodoListArray"
    override func viewDidLoad() {
        super.viewDidLoad()


        if let items = defaults.array(forKey: DEFAULTS_KEY) {
            itemArray = items as! [String]
        }
        // Set navigation attributes
        self.title = "Todo-y"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewItem))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton

        // Register table cells
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoItemCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }


    @objc func addNewItem () {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: self.DEFAULTS_KEY)
            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

