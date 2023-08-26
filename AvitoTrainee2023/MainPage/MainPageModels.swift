//
//  MainPageModels.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

enum MainPageModels {
	struct Request {
		let id: String
	}

	struct Responce {
		let id: String
		let title: String
		let price: String
		let location: String
		let imageURL: String
		let createdDate: String

		struct ResponceProducts {
			let products: [Responce]
		}
	}

	struct ViewModel {
		let title: String
		let price: String
		let location: String
		let image: UIImage
		let createdDate: String
	}
}
