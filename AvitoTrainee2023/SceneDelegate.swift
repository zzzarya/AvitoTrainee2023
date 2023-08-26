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

		window.rootViewController = UINavigationController(rootViewController: MainPageViewController())
		window.makeKeyAndVisible()

		self.window = window
	}
}

