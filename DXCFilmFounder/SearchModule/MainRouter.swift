//
//  MainRouter.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

class MainRouter: MainRouterProtocol {
    
    
    
//        IF USING STORYBOARD
//    static var storyboard: UIStoryboard {
//        return UIStoryboard(name: "Main", bundle: nil)
//    }
    
    static func createMainViewController() -> UIViewController {
  
//        IF USING STORYBOARD
//        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewProtocol else {
//            fatalError("Invalid view controller type")
//        }
        
            let mainViewController = MainViewController()

        
            let presenter: MainPresenterProtocol  = MainPresenter()
            mainViewController.presenter = presenter
            presenter.view = mainViewController
            let interactor: MainInteractorProtocol  = MainInteractor()
            interactor.presenter = presenter
            presenter.interactor = interactor
            let router: MainRouterProtocol  = MainRouter()
            presenter.router = router
        
            return mainViewController
        }
    
    func goToDetail(from view: MainViewProtocol, with film: MovieModel) {
            
        let detailViewController = DetailRouter.createDetailViewController(with: film)
        
        guard let mainViewController = view as? MainViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        mainViewController.navigationController?.pushViewController(detailViewController, animated: true)
    }

}
