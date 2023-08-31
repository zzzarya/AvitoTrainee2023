//
//  DetailsPagePresenter.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.

import UIKit

protocol IDetailsPagePresenter {
	func present(responce: DetailsPageModels.Responce)
	func presentAlert()
}

final class DetailsPagePresenter: IDetailsPagePresenter {

	weak var viewController: IDetailsPageViewController?

	func present(responce: DetailsPageModels.Responce) {
		let dispatchGroup = DispatchGroup()
		var viewModelProduct: DetailsPageModels.ViewModel.ViewModelProduct?

		dispatchGroup.enter()
		mapDataProduct(product: responce.product) { viewModel in
			viewModelProduct = viewModel
			dispatchGroup.leave()
		}

		dispatchGroup.notify(queue: .main) {
			if let viewModelProduct = viewModelProduct {
				let result = DetailsPageModels.ViewModel(viewModelProduct: viewModelProduct)
				self.viewController?.render(viewModel: result)
			} else {
				print("Ошибка viewModelProduct")
			}
		}
	}

	func presentAlert() {
		viewController?.showAlert()
	}

	private func mapDataProduct(
		product: DetailsPageModels.Responce.Product,
		completion: @escaping (DetailsPageModels.ViewModel.ViewModelProduct) -> Void
	) {
		var result = DetailsPageModels.ViewModel.ViewModelProduct(
			title: product.title,
			price: product.price,
			location: "Адрес: " + product.location + ", " + product.address,
			image: UIImage(),
			createdDate: product.createdDate,
			description: product.description,
			email: "✉️ " + product.email,
			phoneNumber: "📞 " + product.phoneNumber
		)

		fetchProductImage(url: product.imageUrl) { image in
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
