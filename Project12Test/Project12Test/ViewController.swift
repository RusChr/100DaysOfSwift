//
//  ViewController.swift
//  Project12Test
//
//  Created by Rustam Chergizbiev on 9/22/22.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let defaults = UserDefaults.standard
		
//		defaults.set(33, forKey: "Age")
//		defaults.set(true, forKey: "UseTouchID")
//		defaults.set(CGFloat.pi, forKey: "PI")
//
//		defaults.set("Paul Hudson", forKey: "Name")
//		defaults.set(Date(), forKey: "LastRun")
//
//		let array = ["Hello", "World"]
//		defaults.set(array, forKey: "SavedArray")
//
//		let dict = ["Name": "Paul", "Country": "UK"]
//		defaults.set(dict, forKey: "SavedDict")
		
		
		let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
		let savedDict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
		
		print(savedArray)
		print(savedDict)
	}


}

