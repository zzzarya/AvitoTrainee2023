//
//  MainPageModels.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

enum MainPageModels {
	struct Responce {
		struct Product {
			let id: String
			let title: String
			let price: String
			let location: String
			let imageURL: String
			let createdDate: String
		}

			let products: [Product]
	}

	struct ViewModel {
		struct ViewModelProduct {
			let id: String
			let title: String
			let price: String
			let location: String
			var image: UIImage?
			let createdDate: String
		}

		let viewModelProducts: [ViewModelProduct]
	}
}
