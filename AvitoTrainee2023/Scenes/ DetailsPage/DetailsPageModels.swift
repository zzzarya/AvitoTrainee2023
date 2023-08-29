//
//  DetailsPageModels.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.

import UIKit

enum DetailsPageModels {
	struct Responce {
		struct Product {
			let title: String
			let price: String
			let location: String
			let imageUrl: String
			let createdDate: String
			let description: String
			let email: String
			let phoneNumber: String
			let address: String
		}

		let product: Product
	}

	struct ViewModel {
		struct ViewModelProduct {
			let title: String
			let price: String
			let location: String
			var image: UIImage
			let createdDate: String
			let description: String
			let email: String
			let phoneNumber: String
		}

		let viewModelProduct: ViewModelProduct
	}
}
