//
//  MainInteractor.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import Foundation

enum MainInteractorError: Error {
    case APIError(Error?)
    case uknown(Error?)
}

final class MainInteractor: MainInteractorProtocol {

    weak var presenter: MainPresenterProtocol?
    let apiDataManager : APIDataManager
//    let localStorageManager:

    init(apiDataManager: APIDataManager = APIDataManager()) {
        self.apiDataManager = apiDataManager
    }

    func getPopularSeries(completion: @escaping (Result<[MovieModel], MainInteractorError>)->Void) {

        apiDataManager.fetchMovies { result in

            switch result {
                case .success(let moviesArray):
                    completion(.success(moviesArray))
                    return

                case .failure(let error):
                    switch error {
                    default:
                        completion(.failure(.APIError(error)))
                    }
            }
        }


    }


    

    
}



