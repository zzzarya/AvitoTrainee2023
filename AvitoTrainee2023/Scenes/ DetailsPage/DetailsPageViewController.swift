//
//  DetailsPageViewController.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.

import UIKit
import SwiftUI

protocol IDetailsPageViewController: AnyObject {
	func render(viewModel: DetailsPageModels.ViewModel)
}

class DetailsPageViewController: UIViewController {
	var interactor: (IDetailsPageInteractor & IDetailsPageStore)?
	var router: (IDetailsPageRouter & IDetailsPageDataPassing)?

	private var viewData: DetailsPageModels.ViewModel?

	private lazy var titleLabel = makeTitleLabel()
	private lazy var priceLabel = makePriceLabel()
	private lazy var addressLabel = makeAddressLabel()
	private lazy var createdDateLabel = makeCreatedDateLabel()
	private lazy var descriptionLabel = makeDescriptionLabel()
	private lazy var emailLabel = makeEmailLabel()
	private lazy var phoneNumberLabel = makePhoneNumberLabel()
	private lazy var imageView = makeImageView()

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		interactor?.viewIsReady()
	}
}

extension DetailsPageViewController: IDetailsPageViewController {
	func render(viewModel: DetailsPageModels.ViewModel) {
		self.viewData = viewModel
		DispatchQueue.main.async {
			self.imageView.image = viewModel.viewModelProduct.image
			self.titleLabel.text = viewModel.viewModelProduct.title
			self.priceLabel.text = viewModel.viewModelProduct.price
			self.addressLabel.text = viewModel.viewModelProduct.location
			self.createdDateLabel.text = viewModel.viewModelProduct.createdDate
			self.descriptionLabel.text = viewModel.viewModelProduct.description
			self.emailLabel.text = viewModel.viewModelProduct.email
			self.phoneNumberLabel.text = viewModel.viewModelProduct.phoneNumber
		}
	}
}

private extension DetailsPageViewController {
	func makeTitleLabel() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 20)
		label.numberOfLines = .zero

		return label
	}

	func makePriceLabel() -> UILabel {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 25)

		return label
	}

	func makeAddressLabel() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 10)
		label.textColor = .darkText

		return label
	}

	func makeCreatedDateLabel() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 8)

		return label
	}

	func makeDescriptionLabel() -> UILabel {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 18)
		label.textColor = .darkText
		label.numberOfLines = .zero

		return label

	}

	func makeEmailLabel() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 15)

		return label
	}

	func makePhoneNumberLabel() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 15)

		return label
	}

	func makeImageView() -> UIImageView {
		let image = UIImageView()
		image.contentMode = .center
		image.backgroundColor = .lightGray
		image.translatesAutoresizingMaskIntoConstraints = false
		image.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
		image.contentMode = .scaleToFill

		let maskLayer = CAShapeLayer()
		maskLayer.path = UIBezierPath(roundedRect: image.bounds, cornerRadius: 15).cgPath
		image.layer.mask = maskLayer

		return image
	}
}

private extension DetailsPageViewController {
	func setupConstraints() {
		let vStack = UIStackView()
		vStack.axis = .vertical
		vStack.spacing = 10
		vStack.translatesAutoresizingMaskIntoConstraints = false
		[
			priceLabel,
			titleLabel,
			addressLabel,
			descriptionLabel,
			emailLabel,
			phoneNumberLabel,
			createdDateLabel
		].forEach{ vStack.addArrangedSubview($0) }

		view.addSubview(imageView)
		view.addSubview(vStack)

		NSLayoutConstraint.activate(
			[
				imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
				imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
				imageView.widthAnchor.constraint(equalToConstant: 350),
				imageView.heightAnchor.constraint(equalToConstant: 350),

				vStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
				vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
				vStack.widthAnchor.constraint(equalToConstant: 350)
			]
		)
	}

	func setup() {
		view.backgroundColor = .lightGray
		navigationController?.navigationBar.tintColor = .black

		setupConstraints()
	}
}
