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

    var itemsArray = [MovieModel]()

    func viewDidAppear() {
        interactor?.getPopularSeries { [weak self] result in
            switch result {
            case .success(let moviesArray):
                self?.itemsArray = moviesArray
                self?.view?.refresh()
            case .failure(let error):
                switch error {
                case .APIError(let error):
                    self?.view?.showAlert(title:"Server Error", message: error?.localizedDescription)
                case .uknown(let error):
                    self?.view?.showAlert(title:"UKnown Error", message: error?.localizedDescription)
                }
            }
        }
    }

    func didSelectRow(_ indexpath: IndexPath) {
        guard let view = view,
              indexpath.row < itemsArray.count
        else { return }

        let movieModel = itemsArray[indexpath.row]
        router?.goToDetail(from: view, with: movieModel)
    }
    
    
}
