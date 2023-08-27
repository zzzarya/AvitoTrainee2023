//
//  DetailsPagePresenter.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.


import UIKit

protocol DetailsPagePresentationLogic
{
  func presentSomething(response: DetailsPage.Something.Response)
}

class DetailsPagePresenter: DetailsPagePresentationLogic
{
  weak var viewController: DetailsPageDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: DetailsPage.Something.Response)
  {
    let viewModel = DetailsPage.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
