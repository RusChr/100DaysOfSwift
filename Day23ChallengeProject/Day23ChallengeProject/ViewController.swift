//
//  ViewController.swift
//  Day23ChallengeProject
//
//  Created by Rustam Chergizbiev on 9/3/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()
    var substr = "@2x.png"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath
        let items = try! fm.contentsOfDirectory(atPath: path!)
        
        for item in items {
            if item.hasSuffix(substr) {
                flags.append(item)
            }
        }
        flags = flags.sorted()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = flags[indexPath.row].replacingOccurrences(of: substr, with: "")
        contentConfig.image = UIImage(named: contentConfig.text!)
        contentConfig.imageToTextPadding = 16.0
        contentConfig.imageProperties.maximumSize = CGSize(width: 50, height: 20)
        
        cell.contentConfiguration = contentConfig
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

