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
    
//    func showSearchResults(_ films: [Film])
    func showReults()
    
    
}

protocol MainPresenterProtocol: class {
    
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    
    func viewDidLoad()
    func getFilmsCollection(_ query: String)
    
    func showSearchResults(_ films: [Film])
    func goToDetail(with film: Film)
    
    func showAlert(_ message: String)

}
protocol MainInteractorProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }
    
    func getFilmsCollection(_ query: String)
    func getFilm(_ id: Int)

   
}

protocol MainRouterProtocol: class {
    
    static func createMainViewController() -> UIViewController
    
    func goToDetail(from view: MainViewProtocol, with film: Film)
    
}
