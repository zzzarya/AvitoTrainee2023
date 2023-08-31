//
//  masd.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.
//

import UIKit

protocol IMainPagePresenter {
	func present(response: MainPageModels.Response)
}

final class MainPagePresenter: IMainPagePresenter {
	weak var viewController: IMainPageViewController?

	func present(response: MainPageModels.Response) {
		let viewModelProducts = mapDataProduct(products: response.products)
		let result = MainPageModels.ViewModel(viewModelProducts: viewModelProducts)
		viewController?.render(viewModel: result)
	}

	private func mapDataProduct(
		products: [MainPageModels.Response.Product]
	) -> [MainPageModels.ViewModel.ViewModelProduct] {
		var viewModelProducts = [MainPageModels.ViewModel.ViewModelProduct]()

		let dispatchGroup = DispatchGroup() // Инициализация DispatchGroup

		for product in products {
			let viewModelProduct = mapDataProduct(product: product)
			viewModelProducts.append(viewModelProduct)

			// Запуск задачи загрузки изображения с помощью DispatchGroup
			dispatchGroup.enter()
			fetchProductImage(url: product.imageURL) { image in
				if let image = image {
					viewModelProduct.image = image
				} else {
					viewModelProduct.image = UIImage()
				}

				// Завершение задачи загрузки изображения
				dispatchGroup.leave()
			}
		}

		// Ожидание завершения всех задач загрузки изображений перед обновлением UI
		dispatchGroup.notify(queue: .main) {
			self.viewController?.render(viewModel: MainPageModels.ViewModel(viewModelProducts: viewModelProducts))
		}

		return viewModelProducts
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
