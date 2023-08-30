//
//  MainPageRouter.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 28.08.2023.

import UIKit

protocol IMainPageRouter {
	func navigateToDetails(id: String)
}

final class MainPageRouter: IMainPageRouter {
	weak var viewController: UIViewController?

	func navigateToDetails(id: String) {
		var detailsScreen: DetailsPageViewController?
		if let screen = DetailsPageAssembly().assembly() as? DetailsPageViewController {
			screen.router?.dataStore?.id = id
			detailsScreen = screen
		}

		if let navigationController = viewController?.navigationController, let detailsVC = detailsScreen {
			navigationController.pushViewController(detailsVC, animated: true)
		}
	}
}
