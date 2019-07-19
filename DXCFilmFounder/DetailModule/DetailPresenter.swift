//
//  DetailPresenter.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import Foundation

class DetailPresenter: DetailPresenterProtocol {
    

    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    
    func viewDidLoad() {
//
//        guard let film = interactor?.film else {return}
//        guard let view = view else {return}
//        view.film = film
        
    }
    
    func showAlert(_ message: String) {
        view?.showAlert(message)
    }    
    
    
    
}
