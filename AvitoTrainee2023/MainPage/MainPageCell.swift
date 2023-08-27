//
//  MainPageCell.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

final class MainPageCell: UICollectionViewCell {
	static let identifier = "MainPageCell"

	private lazy var productImage = makeProductImage()
	private lazy var productName = makeProductName()
	private lazy var productPrice = makeProductPrice()
	private lazy var productLocation = makeProductLocation()
	private lazy var productCreatedDate = makeproductCreatedDate()

	override init(frame: CGRect) {
		super.init(frame: frame)
		applyStyle()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	struct MainPageCellModel {
		let productImage: UIImage
		let productName: String
		let productPrice: String
		let productLocation: String
		let productCreatedDate: String
	}
}

extension MainPageCell.MainPageCellModel: CellViewModel {
	func setup(cell: MainPageCell) {
		cell.productImage.image = productImage
		cell.productName.text = productName
		cell.productPrice.text = productPrice
		cell.productLocation.text = productLocation
		cell.productCreatedDate.text = productCreatedDate
	}
}

private extension MainPageCell {
	func applyStyle() {
//		contentView.backgroundColor = .darkGray
		contentView.layer.cornerRadius = 15
	}

	func setupConstraints() {
		let vStack = UIStackView()
		vStack.axis = .vertical
		vStack.spacing = 5
		[
			productImage,
			productName,
			productPrice,
			productLocation,
			productCreatedDate
		].forEach{ vStack.addArrangedSubview($0) }

		contentView.addSubview(vStack)

		vStack.frame = contentView.bounds
		
	}
}

private extension MainPageCell {
	func makeProductImage() -> UIImageView {
		let image = UIImageView()
		image.contentMode = .center
		image.backgroundColor = .brown
		image.frame = CGRect(x: 0, y: 0, width: 145, height: 145)
		image.contentMode = .scaleToFill

		let maskLayer = CAShapeLayer()
		maskLayer.path = UIBezierPath(roundedRect: image.bounds, cornerRadius: 15).cgPath
		image.layer.mask = maskLayer


		return image
	}

	func makeProductName() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)

		return label
	}

	func makeProductPrice() -> UILabel {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 10)
		label.numberOfLines = .zero

		return label
	}

	func makeProductLocation() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 7)
		label.numberOfLines = .zero

		return label
	}

	func makeproductCreatedDate() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 7)
		label.numberOfLines = .zero

		return label
	}
}
