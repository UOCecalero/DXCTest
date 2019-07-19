//
//  MainPresenter.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?

    func viewDidLoad() {

    }
    
    func showAlert(_ message: String) {
        view?.showAlert(message)
    }
    
    func getFilmsCollection(_ query: String) {
        interactor?.getFilmsCollection(query)
    }
    
    func showSearchResults(_ films: [Film]) {
        
        guard let view = view else {return}
        view.showSearchResults(films)
    }
    
    
    
    
}
