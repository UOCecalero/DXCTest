//
//  DetailProtocols.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

protocol DetailViewProtocol: class {
    
    var presenter: DetailPresenterProtocol? { get set }
    var item: MovieEntity?                   { get set }

    func showAlert(title: String, message: String)

}

protocol DetailPresenterProtocol: class {
    
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    
    func viewDidLoad()

}

protocol DetailInteractorProtocol: class {

    var presenter: DetailPresenterProtocol? { get set }

}

protocol DetailRouterProtocol: class {
    
    static func createDetailViewController(with item: MovieEntity) -> DetailViewController
    
}
