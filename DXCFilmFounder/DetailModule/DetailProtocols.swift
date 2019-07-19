//
//  DetailProtocols.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

protocol DetailViewProtocol: class {
    
    var presenter: DetailPresenterProtocol? {get set}
    var film: Film? {get set}
    
    
    func setUpView()
    func showAlert(_ message: String)
    
    
}

protocol DetailPresenterProtocol: class {
    
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    
    func viewDidLoad()
    
//    func showSearchResults(_ film: Film)

}

protocol DetailInteractorProtocol: class {
    
    var presenter: DetailPresenterProtocol? { get set }
    
//    var film: Film {get set}
    
//    func getFilm(_ id: Int)
    
    
}

protocol DetailRouterProtocol: class {
    
    static func createDetailViewController(with film: Film) -> UIViewController
    
}
