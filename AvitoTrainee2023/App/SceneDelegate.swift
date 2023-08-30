//
//  SceneDelegate.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		window.rootViewController = UINavigationController(rootViewController: MainPageAssembly().assembly())
		window.makeKeyAndVisible()

		self.window = window
	}

//	private func assembly() -> UIViewController {
//		let mainViewController = MainPageAssembly().assembly()
//		let detailsScreen = DetailsPageAssembly().assembly()
//
//		let router = MainPageRouter(
//			viewController: mainViewController,
//			detailsScreen: detailsScreen)
//
//		if let mainViewController = mainViewController as? MainPageViewController {
//			mainViewController.router = router
//		}
//
//		return mainViewController
//	}
}

