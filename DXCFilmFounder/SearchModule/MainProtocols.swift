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
    
}

protocol MainPresenterProtocol: class {
    
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol? { get set }

}
protocol MainInteractorProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }

   
}

protocol MainRouterProtocol: class {
    
    static func create() -> UIViewController
    
//    func goToDetail(from view: MainViewProtocol)
    
}
