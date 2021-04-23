//
//  MainInteractor.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import Foundation

//enum MainInteractorError: Error {
//    case APIError(Error?)
//    case uknown(Error?)
//}

final class MainInteractor: MainInteractorProtocol {

    var items = [MovieEntity]()

    weak var presenter: MainPresenterProtocol?

    let apiDataManager : APIDataManager!
    let localStorageManager: LocalStorageDataManager!

    init(apiDataManager: APIDataManager, localStorageManager: LocalStorageDataManager ) {
        self.apiDataManager = apiDataManager
        self.localStorageManager = localStorageManager
    }

    var page: Int64 = 1
    var maxPage: Int64 = 1
    var processing = false

    var apiCallClousure: (() -> Void)?


    func reload() {
        page = 1
        maxPage = 1
        items = []
    }

    func getPopularSeries() {
        guard processing == false else { return }
              processing = true

        self.apiCallClousure = {
            self.presenter?.showSpinner()
            self.apiDataManager.fetchMovies(inPage: Int(truncatingIfNeeded: self.page)){ [weak self] result in
                self?.presenter?.hideSpinner()

                                switch result {
                                    case .success(let pageResult):
                                        guard self?.page == pageResult.page
                                        else {
                                            self?.presenter?.showAlert(title: "API ERROR", message: "Uknown or unexpected page")
                                            self?.processing = false
                                            return
                                        }
                                        guard let moviesEntityArray = pageResult.results?.array as? [MovieEntity] else { return }
                                        self?.items.append(contentsOf: moviesEntityArray )
                                        self?.page += 1
                                        self?.maxPage = pageResult.totalPages
                                        self?.localStorageManager.saveContext { result in
                                            switch result {
                                            case .success(_):
                                                self?.presenter?.show(items: self?.items ?? [])

                                            case .failure(_):
                                                self?.presenter?.showAlert(title: "STORAGE ERROR", message: "The page has not been saved properly")
                                            }
                                        self?.processing = false
                                        return
                                        }


                                    case .failure(let error):
                                        switch error {
                                        default:
                                            self?.presenter?.showAlert(title: "API ERROR", message: error.localizedDescription)
                                            self?.processing = false
                                        }
                                }
                            }
        }

        presenter?.showSpinner()
        guard page <= maxPage else { return }

        localStorageManager.fetchPagedItems(in: page) { [weak self] result in
                self?.presenter?.hideSpinner()

                switch result {
                case .success(let moviesPageEntity):
                    guard self?.page == moviesPageEntity.page
                    else {
                        self?.presenter?.showAlert(title: "STORAGE ERROR", message: "Uknown or unexpected page")
                        return
                    }
                    guard let moviesEntityArray = moviesPageEntity.results?.array as? [MovieEntity] else { return }
                    self?.items.append(contentsOf: moviesEntityArray)
                    self?.page += 1
                    self?.maxPage = moviesPageEntity.totalPages

                    
                    self?.presenter?.show(items: self?.items ?? [])
                    self?.processing = false
                    return
                    
                case .failure(let error):
                    switch error {
                    default:
                        self?.apiCallClousure?()
                }
            }
        }



    }

    func reloadStorage() {
        guard processing == false else {
            return
        }
        processing = true
        localStorageManager.reloadStorage { [weak self] result in
            switch result {
            case .success:
                self?.page = 1
                self?.maxPage = 1
                self?.items = []
                
                self?.processing = false
                self?.presenter?.viewDidAppear()
            case .failure(_):
                self?.presenter?.showAlert(title: "STORAGE ERROR", message: "The storage has not been deleted")
                self?.processing = false
            }


        }
    }
    
}
