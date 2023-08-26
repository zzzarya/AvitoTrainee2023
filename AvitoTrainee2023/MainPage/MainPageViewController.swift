//
//  MainPageViewController.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

final class MainPageViewController: UIViewController {

	private lazy var collectionView = makeCollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
	}
}

extension MainPageViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		100
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return collectionView.dequeueReusableCell(withReuseIdentifier: "MainPageCell", for: indexPath)
	}


}

extension MainPageViewController: UICollectionViewDelegate {

}

private extension MainPageViewController {
	func setup() {
		view.addSubview(collectionView)
		collectionView.frame = view.bounds

		navigationItem.title = "Avito"
		navigationController?.navigationBar.barTintColor = .gray
		navigationController?.navigationBar.prefersLargeTitles = true

		setupCollectionView()
	}

	func makeCollectionView() -> UICollectionView {
		let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

		collection.backgroundColor = .lightGray

		collection.dataSource = self
		collection.delegate = self

		return collection

	}

	func setupCollectionView() {
		collectionView.register(MainPageCell.self, forCellWithReuseIdentifier: "MainPageCell")
	}
}

