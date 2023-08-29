//
//  MainPageViewController.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

protocol IMainPageViewController: AnyObject {
	func render(viewModel: MainPageModels.ViewModel)
}

final class MainPageViewController: UIViewController {
	var interactor: IMainPageInteractor?
	var router: IMainPageRouter?
	
	private var viewData: MainPageModels.ViewModel = .init(viewModelProducts: [])
	private lazy var collectionView = makeCollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
		interactor?.viewIsReady()
	}
}

extension MainPageViewController: IMainPageViewController {
	func render(viewModel: MainPageModels.ViewModel) {
		self.viewData = viewModel
		DispatchQueue.main.async {
			self.collectionView.reloadData()
		}
	}
}

extension MainPageViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewData.viewModelProducts.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let product = viewData.viewModelProducts[indexPath.row]

		let model = MainPageCell.MainPageCellModel(
			productImage: product.image ?? UIImage(),
			productName: product.title,
			productPrice: product.price,
			productLocation: product.location,
			productCreatedDate: product.createdDate)

		return collectionView.dequeueReusableCell(withModel: model, for: indexPath)
	}
}

extension MainPageViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		
		let product = viewData.viewModelProducts[indexPath.row]
		router?.navigateToDetails(id: product.id)
	}
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let itemsPerRow : CGFloat = 2
		let paddingWidth = 20 * (itemsPerRow + 1)
		let availabelWidth = collectionView.frame.width - paddingWidth
		let withPerItem = availabelWidth / itemsPerRow
		let heightPerItem = withPerItem * 1.27
		return CGSize(width: withPerItem, height: heightPerItem)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		UIEdgeInsets(top: 5, left: 30, bottom: 20, right: 10)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		30
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat {
		20
	}
}

private extension MainPageViewController {
	func makeCollectionView() -> UICollectionView {
		let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

		collection.backgroundColor = .lightGray

		collection.dataSource = self
		collection.delegate = self

		return collection

	}

	func setup() {
		view.addSubview(collectionView)
		collectionView.frame = view.bounds

		navigationItem.title = "Avito"
		navigationController?.navigationBar.barTintColor = .gray
		navigationController?.navigationBar.prefersLargeTitles = true

		setupCollectionView()
	}

	func setupCollectionView() {
		collectionView.register(MainPageCell.self, forCellWithReuseIdentifier: "MainPageCell")
	}
}

