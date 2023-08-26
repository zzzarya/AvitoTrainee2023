//
//  MainPageViewController.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

protocol IMainPageViewController {
	func render(viewModel: MainPageModels.ViewModel)
}

final class MainPageViewController: UIViewController {

	private lazy var collectionView = makeCollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
	}
}

extension MainPageViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		10
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let model = MainPageCell.MainPageCellModel(
			productImage: UIImage(systemName: "backpack.circle")!,
			productName: "123",
			productPrice: "123",
			productLocation: "123",
			productCreatedDate: "123")

		return collectionView.dequeueReusableCell(withModel: model, for: indexPath)
	}
}

extension MainPageViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
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
		let heightPerItem = withPerItem * 1.6
		return CGSize(width: withPerItem, height: heightPerItem)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		UIEdgeInsets(top: 5, left: 20, bottom: 20, right: 20)
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

