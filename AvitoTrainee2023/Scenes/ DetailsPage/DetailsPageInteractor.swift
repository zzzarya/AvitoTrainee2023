//
//  DetailsPageInteractor.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.

import UIKit

protocol IDetailsPageInteractor {
	func viewIsReady()
//	func fetchId()
}

protocol IDetailsPageStore: AnyObject {
	var id: String { get set }
}

final class DetailsPageInteractor: IDetailsPageInteractor, IDetailsPageStore {
	var id: String = ""
	private let presenter: IDetailsPagePresenter

	init(presenter: IDetailsPagePresenter) {
		self.presenter = presenter
	}

	func viewIsReady() {
		createResponce { responce in
			self.presenter.present(responce: responce)
		}
	}

	private func createResponce(completion: @escaping (DetailsPageModels.Responce) -> Void) {
		let detailUrl = URLs.detailUrl.rawValue + id + ".json"

		NetworkManager.shared.fetch(dataType: ProductDetails.self, from: detailUrl) { result in
			switch result {
			case .success(let product):
				completion(DetailsPageModels.Responce(product: self.mapDrpoductData(product: product)))
			case .failure(let error):
				print(error)
			}
		}
	}

	private func mapDrpoductData(product: ProductDetails) -> DetailsPageModels.Responce.Product {
		let result = DetailsPageModels.Responce.Product(
			title: product.title,
			price: product.price,
			location: product.location,
			imageUrl: product.imageUrl,
			createdDate: product.createdDate,
			description: product.description,
			email: product.email,
			phoneNumber: product.phoneNumber,
			address: product.address
		)

		return result
	}

//	func fetchId() {
//		print("id: \(id)")
//	}
}
