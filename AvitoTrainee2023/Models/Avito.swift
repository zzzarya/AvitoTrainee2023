//
//  Avito.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import Foundation

struct Avito: Decodable {
	let advertisements: [Advertisements]
}

struct Advertisements: Decodable {
	let id: String
	let title: String
	let price: String
	let location: String
	let imageUrl: String
	let createdDate: String
}
