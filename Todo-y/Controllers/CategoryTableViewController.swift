//
//  CategoryTableViewController.swift
//  Todo-y
//
//  Created by Benjamin, Matthew on 4/12/19.
//  Copyright © 2019 Benjamin, Matthew. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")

        // Set navigation attributes
        self.title = "Categories"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewCategory))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton

        loadCategories()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categoryArray[indexPath.row]
        cell.textLabel?.text = item.name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = TodoListViewController()
        nextViewController.categoryData = categoryArray[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    @objc func addNewCategory() {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)

            self.saveCategories()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // Mark - Save and load from CoreData

    func saveCategories () {
        do {
            try context.save()
        } catch {
            print("Error on saveItem \(error)")
        }


        self.tableView.reloadData()
    }

    func loadCategories (with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }

        tableView.reloadData()
    }

}
