//
//  APIDataManager.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 15/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import Foundation


protocol RequestBuilder {
    var urlRequest: URLRequest { get }
}

enum TheMovieDBEndpoint {

    struct Constants {
        static let APIKey = "c6aeee577586ba38e487b74dfede5deb"
        static let locale = Locale.current.languageCode
    }

    case popularSeries(Int)
}

extension TheMovieDBEndpoint: RequestBuilder {

    var urlRequest: URLRequest {
        switch self {
        case .popularSeries(let page):
            guard let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(Constants.APIKey)&language=\(Constants.locale ?? "es-ES")&page=\(page)")
            else {  preconditionFailure("Invalid URL format")   }
            let request = URLRequest(url: url)
            return request
        }
    }
}

class APIDataManager: MainDataManagerProtocol {

    var session: URLSession

    typealias T = ResultsModel<MovieModel>
    typealias E = APIDataManagerError

    var page: Int = 1
    var maxPage: Int = 1
    var buffer = [MovieModel]()

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func reload() {
        page = 1
        maxPage = 1
        buffer = []
    }


    func fetchMovies(completion: @escaping FetchResult<[MovieModel], APIDataManagerError>) {

        guard page <= maxPage else { completion(.failure(.noMorePages)); return }

        self.fetchItems(from: TheMovieDBEndpoint.popularSeries(page)) { [weak self] result in

            switch result {
                case .success(let pageResult):
//                    guard page == pageResult.page else { completion(.failure(.unexpectedPage))}
                    guard self?.page == pageResult.page else { completion(.success(self?.buffer ?? [])); return }

                    self?.page += 1
                    self?.maxPage = pageResult.totalPages ?? 1
                    self?.buffer.append(contentsOf: pageResult.results.compactMap{ $0 })
                    completion(.success(self?.buffer ?? []))

            case .failure(let error):
                completion(.failure(error))
            }

        }
    }

}
