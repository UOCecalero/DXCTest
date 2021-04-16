//
//  DetailRouter.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

class DetailRouter: DetailRouterProtocol {
    
    static func createDetailViewController(with item: MovieModel) -> UIViewController {
        
        let detailViewController = DetailViewController()
        
        let presenter: DetailPresenterProtocol  = DetailPresenter()
            detailViewController.presenter = presenter
            presenter.view = detailViewController
        let interactor: DetailInteractorProtocol  = DetailInteractor()
            interactor.presenter = presenter
            presenter.interactor = interactor
        let router: DetailRouterProtocol  = DetailRouter()
            presenter.router = router
        detailViewController.item = item
        
        return detailViewController
    }
    
}

