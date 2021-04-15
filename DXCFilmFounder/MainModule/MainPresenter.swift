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

    //PRESENTER -> INTERACTOR
    func fetchItems(_ query: String) {
        interactor?.fetchItems(query)
    }
    
    func getMoreFilms(_ query: String){
        interactor?.getMoreFilms(query)
    }
    
    func showAlert(_ message: String) {
        view?.showAlert(message)
    }
    
    //PRESENTER -> VIEW
    func setTable(_ films: [Film]) {
        guard let view = view else {return}
        view.setTable(films)
    }
    
    func addRows(_ films: [Film]) {
        guard let view = view else {return}
        view.addRows(films)
    }
    
    
    //PRESENTER ->ROUTER
    func goToDetail(with film: Film) {
        
        guard let view = view else {return}
        router?.goToDetail(from: view, with: film)
    }
    
    
}
