//
//  MainProtocols.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class  {

    associatedtype T: Codable
    associatedtype P: MainPresenterProtocol
    
    var presenter: P? { get set }
    
    var itemsArray: [T]? { get set }
//    var searchController: UISearchController {get set}
    
    
    func setUpView()
    func showAlert(_ message: String)

}

extension MainViewProtocol {

    func setTable(_ films: [T]) {

    }

    func addRows(_ films: [T])

}

protocol MainPresenterProtocol: class {

    associatedtype T: Codable
    associatedtype V: MainViewProtocol
    associatedtype I: MainInteractorProtocol
    associatedtype R: MainRouterProtocol
    
    var view: V?  { get set }
    var interactor: I? { get set }
    var router: R? { get set }

    
    // MARK: Interface Presenter -> Interactor
    func fetchItems(_ query: String)
    func getMoreFilms(_ query: String)
    
    
    // MARK: Interface Presenter -> View
    func setTable(_ films: [T])
    func addRows(_ films: [T])
    func showAlert(_ message: String)
    
    
    //MARK: Interface Presenter -> Router
    func goToDetail(with film: Film)
}


protocol MainInteractorProtocol: class {

    associatedtype T: Codable
    associatedtype P: MainPresenterProtocol
    
    var presenter: P? { get set }
    
    func fetchItems(_ query: String)
//    func getMoreFilms(_ query: String)
//    func getFilm(_ id: Int)

   
}

protocol MainRouterProtocol: class {

    associatedtype M: MainViewProtocol
    
    static func createMainViewController() -> UIViewController
    
    func goToDetail(from view: M, with film: Film)
    
}
