//
//  MainProtocols.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
    
    var presenter: MainPresenterProtocol?   { get set }

    var items: [MovieEntity] { get set }

    func show(items: [MovieEntity])
    func showSpinner()
    func hideSpinner()
    func showAlert(title: String, message: String?)
}

protocol MainPresenterProtocol: class {
    
    var view: MainViewProtocol?             { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol?         { get set }

    func viewDidAppear()
    func viewDidLoad()
    func scrolldidReachEnd()
    func reset()
    func didSelectRow(with item: MovieEntity)

    func show(items: [MovieEntity])
    func showSpinner()
    func hideSpinner()
    func showAlert(title: String, message: String?)

}


protocol MainInteractorProtocol: class {
    
    var presenter: MainPresenterProtocol?      { get set }

    func getPopularSeries()
    func reloadStorage()

}

protocol MainRouterProtocol: class {

    static func createMainViewController() -> UIViewController

    func goToDetail(from view: MainViewProtocol, with item: MovieEntity)

}
