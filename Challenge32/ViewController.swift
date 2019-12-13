//
//  ViewController.swift
//  Challenge32
//
//  Created by Appinventiv on 08/12/19.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemAlert))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteList))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        toolbarItems = [share]
        navigationController?.isToolbarHidden = false
        
        
    }
    
    @objc func shareTapped() {
        
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
//        vc.popoverPresentationController = toolbarItems?[0]
        present(vc, animated: true, completion: nil)
    }
    
    @objc func addItemAlert() {
        let ac = UIAlertController(title: "Add Item to List", message: "", preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(action)
        present(ac, animated: true, completion: nil)
        
    }
    
    func submit(_ answer: String) {
        shoppingList.insert(answer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    
    @objc func deleteList() {
        
        shoppingList.removeAll()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
        
    }

}

