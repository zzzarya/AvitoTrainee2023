//
//  DetailsPageInteractor.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.

import UIKit

protocol DetailsPageBusinessLogic
{
  func doSomething(request: DetailsPage.Something.Request)
}

protocol DetailsPageDataStore
{
  //var name: String { get set }
}

class DetailsPageInteractor: DetailsPageBusinessLogic, DetailsPageDataStore
{
  var presenter: DetailsPagePresentationLogic?
  var worker: DetailsPageWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: DetailsPage.Something.Request)
  {
    worker = DetailsPageWorker()
    worker?.doSomeWork()
    
    let response = DetailsPage.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
