//
//  DetailsPageRouter.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 27.08.2023.

import UIKit

protocol IDetailsPageRouter {

}

protocol IDetailsPageDataPassing {
	var dataStore: IDetailsPageStore? { get }
}

class DetailsPageRouter: IDetailsPageRouter, IDetailsPageDataPassing {
	weak var dataStore: IDetailsPageStore?
}
