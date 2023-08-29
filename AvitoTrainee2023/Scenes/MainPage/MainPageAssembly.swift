//
//  MainPageAssembly.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.
//

import UIKit

protocol IAssembly {
	func assembly() -> UIViewController
}

final class MainPageAssembly: IAssembly {
	func assembly() -> UIViewController {
		let viewController = MainPageViewController()
		let presenter = MainPagePresenter()
		let interactor = MainPageInteractor(presenter: presenter)
		let router = MainPageRouter()
		viewController.interactor = interactor
		viewController.router = router
		presenter.viewController = viewController
		router.viewController = viewController

		return viewController
	}
}
