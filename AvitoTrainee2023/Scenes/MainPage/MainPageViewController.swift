//
//  MainPageViewController.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import UIKit

protocol IMainPageViewController: AnyObject {
	func render(viewModel: MainPageModels.ViewModel)
	func showAlert()
}

final class MainPageViewController: UIViewController {
	var interactor: IMainPageInteractor?
	var router: IMainPageRouter?
	
	private var viewData: MainPageModels.ViewModel = .init(viewModelProducts: [])
	private var activityIndicator: UIActivityIndicatorView?

	private var refreshControl: UIRefreshControl {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
		return refreshControl
	}

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
			self.activityIndicator?.stopAnimating()
		}
	}

	func showAlert() {
		let alert = UIAlertController(
			title: "No internet connection",
			message: "Please check your internet connection",
			preferredStyle: .alert
		)

		let okAction = UIAlertAction(title: "OK", style: .default)

		alert.addAction(okAction)
		present(alert, animated: true)

		activityIndicator?.stopAnimating()
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
			productCreatedDate: product.createdDate
		)

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
		let itemsPerRow: CGFloat = 2
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
		collectionView.frame = view.bounds
		collectionView.refreshControl = refreshControl

		view.addSubview(collectionView)

		navigationItem.title = "Avito"
		navigationController?.navigationBar.barTintColor = .gray
		navigationController?.navigationBar.prefersLargeTitles = true

		setupCollectionView()
		activityIndicator = showSpinner(in: view)
	}

	func setupCollectionView() {
		collectionView.register(MainPageCell.self, forCellWithReuseIdentifier: "MainPageCell")
	}

	func showSpinner(in view: UIView) -> UIActivityIndicatorView {
		let activityIndicator = UIActivityIndicatorView(style: .large)
		activityIndicator.color = .white
		activityIndicator.startAnimating()
		activityIndicator.center = view.center
		activityIndicator.hidesWhenStopped = true

		view.addSubview(activityIndicator)

		return activityIndicator
	}

	@objc func refresh(sender: UIRefreshControl) {
		interactor?.viewIsReady()
		sender.endRefreshing()
	 }
}
