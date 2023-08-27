//
//  DetailsPageRouter.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.

import UIKit

@objc protocol DetailsPageRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DetailsPageDataPassing
{
  var dataStore: DetailsPageDataStore? { get }
}

class DetailsPageRouter: NSObject, DetailsPageRoutingLogic, DetailsPageDataPassing
{
  weak var viewController: DetailsPageViewController?
  var dataStore: DetailsPageDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: DetailsPageViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: DetailsPageDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
