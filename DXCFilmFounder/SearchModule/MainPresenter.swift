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

    func viewDidLoad() {}

    func viewDidAppear() {
        interactor?.getPopularSeries()
    }

    func scrolldidReachEnd() {
        interactor?.getPopularSeries()
    }

    func reset() {
        interactor?.reloadStorage()
    }

    func show(items: [MovieModel]) {
        view?.show(items: items)
    }

    func showSpinner() {
        view?.showSpinner()
    }

    func hideSpinner() {
        view?.hideSpinner()
    }

    func showAlert(title: String, message: String?) {
        view?.showAlert(title: title, message: message)
    }

    func didSelectRow(with item: MovieModel) {
        guard let view = view else { return }
        router?.goToDetail(from: view, with: item)
    }

    
    
}
