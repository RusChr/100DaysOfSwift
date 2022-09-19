//
//  ViewController.swift
//  Project7
//
//  Created by Rustam Chergizbiev on 9/9/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        let filterItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showFilteredPetitions))
        let clearFilterItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(resetFilter))
        navigationItem.leftBarButtonItems = [filterItem, clearFilterItem]
        
        
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
		DispatchQueue.global(qos: .userInitiated).async {
			if let url = URL(string: urlString) {
				if let data = try? Data(contentsOf: url) {
					self.parse(json: data)
					return
				}
			}
			self.showError()
		}
    }
	
	
	func parse(json: Data) {
		let decoder = JSONDecoder()

		if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
			petitions = jsonPetitions.results
			filteredPetitions = petitions
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let petition = filteredPetitions[indexPath.row]
        
        content.text = petition.title
        content.secondaryText = petition.body
        content.textProperties.numberOfLines = 2
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        content.secondaryTextProperties.numberOfLines = 4
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func showError() {
		DispatchQueue.main.async {
			let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(ac, animated: true)
		}
    }
    
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    
    @objc func showFilteredPetitions() {
        let ac = UIAlertController(title: "Filter", message: "Enter to filter", preferredStyle: .alert)
        ac.addTextField()
        
        let filterAction = UIAlertAction(title: "Filter", style: .default) { [weak self, weak ac] _ in
            guard let self = self, let ac = ac else { return }
            if let item = ac.textFields?[0].text?.lowercased() {
                self.filteredPetitions.removeAll(keepingCapacity: true)
                
                for petition in self.petitions {
                    if petition.body.lowercased().contains(item) {
                        self.filteredPetitions.insert(petition, at: self.filteredPetitions.startIndex)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        ac.addAction(filterAction)
        present(ac, animated: true)
    }
    
    
    @objc func resetFilter() {
        filteredPetitions = petitions
        tableView.reloadData()
    }
}


