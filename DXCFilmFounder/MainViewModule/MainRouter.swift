//
//  MainRouter.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

class MainRouter: MainRouterProtocol {

    //static let dataController = DataController(modelName: "MoviesStorage")

    
    static func createMainViewController() -> UIViewController {
  
            let mainViewController = MainViewController()

            let presenter: MainPresenterProtocol  = MainPresenter()
                mainViewController.presenter = presenter
                presenter.view = mainViewController


            let dataController = DataController(modelName: "MoviesStorage")
                dataController.load()
        
            let localStorageDataManager = LocalStorageDataManager(dataController: dataController)
            let decoder: JSONDecoder = newJSONDecoder(with: dataController.viewContext)
            let apiDataManager = APIDataManager(decoder: decoder)

            let interactor: MainInteractorProtocol  = MainInteractor(apiDataManager: apiDataManager, localStorageManager: localStorageDataManager)
                interactor.presenter = presenter
                presenter.interactor = interactor

            let router: MainRouterProtocol  = MainRouter()
                presenter.router = router
        
            return mainViewController
        }
    
    func goToDetail(from view: MainViewProtocol, with item: MovieEntity) {
            
        let detailViewController = DetailRouter.createDetailViewController(with: item)
        
        guard let mainViewController = view as? MainViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        mainViewController.navigationController?.pushViewController(detailViewController, animated: true)
    }

}
