//
//  MainPageInteractor.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import Foundation

protocol IMainPageInteractor {
	func viewIsReady()
}

final class MainPageInteractor: IMainPageInteractor {
	private let presenter: IMainPagePresenter

	init(presenter: IMainPagePresenter) {
		self.presenter = presenter
	}

	func viewIsReady() {
		NetworkMonitor.shared.startMonitoring { [weak self] isConnected in
			if isConnected {
				self?.createResponce { responce in
					self?.presenter.present(responce: responce)
				}
			} else {
				DispatchQueue.main.async {
					self?.presenter.presentAlert()
				}
			}
		}
	}

	private func createResponce(completion: @escaping (MainPageModels.Responce) -> Void) {
		var responceProducts: [MainPageModels.Responce.Product] = []

		NetworkManager.shared.fetch(dataType: Avito.self, from: URLs.mainUrl.rawValue) { result in
			switch result {
			case .success(let products):
				let responce = MainPageModels.Responce(products: self.mapProductData(products: products.advertisements))
				responceProducts += responce.products
				completion(MainPageModels.Responce(products: responceProducts))
			case .failure(let error):
				print(error)
				completion(MainPageModels.Responce(products: []))
			}
		}
	}

	private func mapProductData(products: [Advertisements]) -> [MainPageModels.Responce.Product] {
		products.map { mapProductData(product: $0) }
	}

	private func mapProductData(product: Advertisements) -> MainPageModels.Responce.Product {
		let result = MainPageModels.Responce.Product(
			id: product.id,
			title: product.title,
			price: product.price,
			location: product.location,
			imageURL: product.imageUrl,
			createdDate: product.createdDate
		)

		return result
	}
}
