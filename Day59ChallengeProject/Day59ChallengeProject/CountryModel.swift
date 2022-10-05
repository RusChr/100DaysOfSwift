//
//  CountryModel.swift
//  Day59ChallengeProject
//
//  Created by Rustam Chergizbiev on 10/5/22.
//

import Foundation

struct Country: Codable {
	let name: Name
	let currencies: Currency
	let capital: [String]
	let region: String
	let flag: String
	
	struct Name: Codable {
		let common: String
		let official: String
	}
	
	struct Currency: Codable {
		typealias CurrencyCode = String
		let currency: [CurrencyCode: CurrencyData]
		
		struct CurrencyData: Codable {
			let name: String
			let symbol: String
		}
		
		init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			currency = try container.decode([CurrencyCode: CurrencyData].self)
		}
	}
}
