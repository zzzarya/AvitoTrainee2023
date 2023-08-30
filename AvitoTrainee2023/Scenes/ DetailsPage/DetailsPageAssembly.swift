//
//  DetailsPageAssembly.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 28.08.2023.
//

import UIKit

final class DetailsPageAssembly: IAssembly {
	func assembly() -> UIViewController {
		let viewController = DetailsPageViewController()
		let presenter = DetailsPagePresenter()
		let interactor = DetailsPageInteractor(presenter: presenter)
		let router = DetailsPageRouter()
		router.dataStore = interactor
		viewController.interactor = interactor
		presenter.viewController = viewController
		viewController.router = router
		
		return viewController
	}
}
