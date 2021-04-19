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

    var items = [MovieModel]()

    weak var presenter: MainPresenterProtocol?

    let apiDataManager : APIDataManager!
    let localStorageManager: LocalStorageDataManager!

    init(apiDataManager: APIDataManager = APIDataManager(), localStorageManager: LocalStorageDataManager ) {
        self.apiDataManager = apiDataManager
        self.localStorageManager = localStorageManager
    }

    var page: Int = 1
    var maxPage: Int = 1
    var processing = false

    var apiCallClousure: (() -> Void)?

    lazy var encoder = newJSONEncoder()


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
            self.apiDataManager.fetchMovies(inPage: self.page) { [weak self] result in
                self?.presenter?.hideSpinner()

                                switch result {
                                    case .success(let pageResult):
                                        guard self?.page == pageResult.page
                                        else {
                                            self?.presenter?.showAlert(title: "API ERROR", message: "Uknown or unexpected page")
                                            self?.processing = false
                                            return
                                        }
                                        self?.page += 1
                                        if let totalPages = pageResult.totalPages { self?.maxPage = totalPages }
                                        self?.items.append(contentsOf: pageResult.results.compactMap{ $0 })
                                        self?.localStorageManager.savePage(pageResult) { [weak self] result in
                                            switch result {
                                                case .success:
                                                    break
                                            case .failure(_):
                                                    self?.presenter?.showAlert(title: "STORAGE ERROR", message: "The page hasn't been saved")
                                            }
                                            self?.presenter?.show(items: self?.items ?? [])
                                            self?.processing = false
                                        }
                                        return

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

            localStorageManager.fetchMoviesPage(inPage: page) { [weak self] result in
                self?.presenter?.hideSpinner()

                switch result {
                case .success(let moviesPageEntity):
                    guard self?.page == Int(moviesPageEntity.page)
                    else {
                        self?.presenter?.showAlert(title: "STORAGE ERROR", message: "Uknown or unexpected page")
                        return
                    }
                    self?.page += 1
                    self?.maxPage = Int(truncatingIfNeeded: moviesPageEntity.totalPages)

                    var movieModelArray = [MovieModel]()

                    moviesPageEntity.results?.forEach { element in
                        guard let element = element as? MovieEntity else {
                            fatalError("Incorrecet type type")
                        }
                        let model = MovieModel.init(backdropPath: element.backdropPath,
                                                    firstAirDate: element.firstAirDate,
                                                    genreIDS: [Int(truncatingIfNeeded: element.genreIDS)],
                                                    id: Int(truncatingIfNeeded:  element.id),
                                                    name: element.name,
                                                    originCountry: [element.originCountry ?? ""],
                                                    originalLanguage: element.originalLanguage,
                                                    originalName: element.originalName,
                                                    overview: element.overview,
                                                    popularity: element.popularity,
                                                    posterPath: element.posterPath,
                                                    voteAverage: element.voteAverage,
                                                    voteCount: Int(truncatingIfNeeded: element.voteCount))
                        movieModelArray.append(model)
                    }

                    self?.items.append(contentsOf: movieModelArray)
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

                self?.presenter?.viewDidAppear()
            case .failure(_):
                self?.presenter?.showAlert(title: "STORAGE ERROR", message: "The storage has not been deleted")
            }
            self?.processing = false

        }
    }
    
}



