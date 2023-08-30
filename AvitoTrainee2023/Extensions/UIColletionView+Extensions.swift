//
//  UIColletionView+Extensions.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

extension UICollectionView {
	func dequeueReusableCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UICollectionViewCell {
		let identifier = String(describing: type(of: model).cellAnyType)
		let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
		model.setupAny(cell: cell)

		return cell
	}

	func register(models: [CellViewAnyModel.Type]) {
		for model in models {
			let identifier = String(describing: model.cellAnyType)
			self.register(model.cellAnyType, forCellWithReuseIdentifier: identifier)
		}
	}
}
