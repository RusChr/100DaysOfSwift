//
//  ViewController.swift
//  Project1
//
//  Created by Rustam Chergizbiev on 8/31/22.
//

import UIKit

class ViewController: UITableViewController {
	
    var pictures = [String]()
	var viewCnt = 0
	

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures = pictures.sorted()
    }
	
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
	
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		let currentItem = pictures[indexPath.row]
		viewCnt = viewCount(for: currentItem)
        cell.textLabel?.text = currentItem
		cell.detailTextLabel?.text = "views: \(viewCnt)"
        return cell
    }
    
	
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
			let currentItem = pictures[indexPath.row]
            vc.selectedImage = currentItem
            vc.detailVCTitle = "Picture \(indexPath.row + 1) of \(pictures.count)"
            vc.activityVCTitle = currentItem
            navigationController?.pushViewController(vc, animated: true)
			
			viewCnt = viewCount(for: currentItem) + 1
			save(value: viewCnt, for: currentItem)
        }
    }

	
	func save(value: Int, for key: String) {
		let defaults = UserDefaults.standard
		defaults.set(value, forKey: key)
		tableView.reloadData()
	}
	
	
	func viewCount(for key: String) -> Int {
		let defaults = UserDefaults.standard
		
		if let savedViewCnt = defaults.object(forKey: key) as? Int {
			return savedViewCnt
		}
		
		return 0
	}
}

