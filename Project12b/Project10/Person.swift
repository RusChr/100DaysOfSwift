//
//  Person.swift
//  Project10
//
//  Created by Rustam Chergizbiev on 9/17/22.
//

import UIKit

class Person: Codable {
	
	var name: String
	var image: String
	
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}

}
