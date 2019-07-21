//
//  MainProtocols.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
    
    var presenter: MainPresenterProtocol? {get set}
    
    var filmsArray: [Film]? {get set}
    var searchController: UISearchController {get set}
    
    
    func setUpView()
    func showAlert(_ message: String)
    
    func setTable(_ films: [Film])
    func addRows(_ films: [Film])
    
    
}

protocol MainPresenterProtocol: class {
    
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol? { get set }

    
    //PRESENTER -> INTERACTOR
    func getFilmsCollection(_ query: String)
    func getMoreFilms(_ query: String)
    
    
    //PRESENTER -> VIEW
    func setTable(_ films: [Film])
    func addRows(_ films: [Film])
    func showAlert(_ message: String)
    
    
    //PRESENTER -> ROUTER
    func goToDetail(with film: Film)


}


protocol MainInteractorProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }
    
    func getFilmsCollection(_ query: String)
    func getMoreFilms(_ query: String)
    func getFilm(_ id: Int)

   
}

protocol MainRouterProtocol: class {
    
    static func createMainViewController() -> UIViewController
    
    func goToDetail(from view: MainViewProtocol, with film: Film)
    
}
