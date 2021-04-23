//
//  LocalStoragreDataManager.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 18/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import UIKit
import CoreData


class LocalStorageDataManager {

    var dataController: DataController

    init(dataController: DataController) {
        self.dataController = dataController
    }
}

extension  LocalStorageDataManager: LocalStorageDataManagerProtocol {

    typealias T = PageEntity
    typealias E = LocalStorageDataManagerError

    func fetchMoviesPage(inPage page: Int64, completion: @escaping (Result<PageEntity, LocalStorageDataManagerError>)->() ){
        self.fetchPagedItems(in: page) { result in
        switch result {
        case .success(let page):
            completion(.success(page))
                    return
        case .failure(let error):
                    completion(.failure(error))
                    return
            }
        }
    }
}
