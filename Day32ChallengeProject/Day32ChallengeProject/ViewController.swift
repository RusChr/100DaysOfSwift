//
//  ViewController.swift
//  Day32ChallengeProject
//
//  Created by Rustam Chergizbiev on 9/9/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToShoppingList))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = shoppingList[indexPath.row]
        cell.contentConfiguration = contentConfig
        return cell
    }
    
    @objc func clearShoppingList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func addToShoppingList() {
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            if let item = ac?.textFields?[0].text {
                self?.shoppingList.insert(item.capitalized, at: 0)
                
                let indexPath = IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        
        ac.addAction(addAction)
        present(ac, animated: true)
    }
}

