//
//  MainPageInteractor.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import Foundation

protocol IMainPageInteractor {
	func viewIsReady()
	func didProductSelected(at indexPath: IndexPath)
}

final class MainPageInteractor: IMainPageInteractor {
	private let presenter: IMainPagePresenter

	init(presenter: IMainPagePresenter) {
		self.presenter = presenter
	}

	func viewIsReady() {
		let responce = createResponce()
		presenter.present(responce: responce)
	}

	func didProductSelected(at indexPath: IndexPath) {
		
	}

	private func createResponce() -> MainPageModels.Responce {

	}
}
