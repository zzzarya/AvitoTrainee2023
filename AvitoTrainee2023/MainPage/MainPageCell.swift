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
		vStack.spacing = 10
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
		image.layer.cornerRadius = 15
		image.frame.size = CGSize(width: 25, height: 15)

		return image
	}

	func makeProductName() -> UILabel {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 10)
		label.numberOfLines = .zero
		label.backgroundColor = .black
		label.textColor = .white

		return label
	}

	func makeProductPrice() -> UILabel {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 10)
		label.numberOfLines = .zero
		label.backgroundColor = .black
		label.textColor = .white

		return label
	}

	func makeProductLocation() -> UILabel {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 10)
		label.numberOfLines = .zero
		label.backgroundColor = .black
		label.textColor = .white

		return label
	}

	func makeproductCreatedDate() -> UILabel {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 10)
		label.numberOfLines = .zero
		label.backgroundColor = .black
		label.textColor = .white

		return label
	}
}
