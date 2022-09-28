//
//  Photo.swift
//  Day50ChallengeProject
//
//  Created by Rustam Chergizbiev on 9/26/22.
//

import UIKit

class Photo: Codable {
	
	var name: String
	var image: String
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}

}
