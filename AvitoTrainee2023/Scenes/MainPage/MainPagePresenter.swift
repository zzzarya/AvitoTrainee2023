//
//  MainPagePresenter.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

protocol IMainPagePresenter {
	func present(responce: MainPageModels.Responce)
	func presentAlert()
}

final class MainPagePresenter: IMainPagePresenter {
	weak var viewController: IMainPageViewController?

	func present(responce: MainPageModels.Responce) {
		let dispatchGroup = DispatchGroup()
		var viewModelProducts: [MainPageModels.ViewModel.ViewModelProduct] = []

		for product in responce.products {
			dispatchGroup.enter()
			mapDataProduct(product: product) { viewModelProduct in
				viewModelProducts.append(viewModelProduct)
				dispatchGroup.leave()
			}
		}

		dispatchGroup.notify(queue: .main) {
			let result = MainPageModels.ViewModel(viewModelProducts: viewModelProducts)
			self.viewController?.render(viewModel: result)
		}
	}

	func presentAlert() {
		viewController?.showAlert()
	}

	private func mapDataProduct(
		product: MainPageModels.Responce.Product,
		completion: @escaping (MainPageModels.ViewModel.ViewModelProduct) -> Void
	) {
		var result = MainPageModels.ViewModel.ViewModelProduct(
			id: product.id,
			title: product.title,
			price: product.price,
			location: product.location,
			image: nil,
			createdDate: product.createdDate)
		
		fetchProductImage(url: product.imageURL) { image in
			if let image = image {
				result.image = image
			} else {
				result.image = UIImage()
			}

			DispatchQueue.main.async {
				completion(result)
			}
		}
	}

	private func fetchProductImage(url: String, completion: @escaping (UIImage?) -> Void) {
		NetworkManager.shared.fetchImage(from: url) { imageData in
			switch imageData {
			case .success(let imageData):
				completion(UIImage(data: imageData))
			case .failure(let error):
				print(error)
				completion(nil)
			}
		}
	}
}

