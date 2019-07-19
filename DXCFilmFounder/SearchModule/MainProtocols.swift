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
    
    
}

protocol MainPresenterProtocol: class {
    
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    
    func viewDidLoad()
    func getFilms()

}
protocol MainInteractorProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }
    
    func getFilms()

   
}

protocol MainRouterProtocol: class {
    
    static func createMainViewController() -> UIViewController
    
//    func goToDetail(from view: MainViewProtocol)
    
}
