//
//  ViewController.swift
//  Day59ChallengeProject
//
//  Created by Rustam Chergizbiev on 10/5/22.
//

import UIKit

class ViewController: UITableViewController {
	
	var countries = [Country]()
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Countries"
		
		if let jsonUrl = Bundle.main.url(forResource: "countries", withExtension: "json") {
			if let jsonData = try? Data(contentsOf: jsonUrl) {
				parse(json: jsonData)
			}
		}
	}
	
	
	func parse(json: Data) {
		if let jsonCountry = try? JSONDecoder().decode([Country].self, from: json) {
			countries = jsonCountry
		}
	}

	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countries.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let country = countries[indexPath.row]
		let flagImage = country.flag
		var content = cell.defaultContentConfiguration()
		
		content.text = "\(flagImage) \(country.name.common)"
		cell.contentConfiguration = content
		return cell
	}
	
}
