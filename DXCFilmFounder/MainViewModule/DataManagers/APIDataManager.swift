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
    var decoder: JSONDecoder

    typealias T = PageEntity
    typealias E = APIDataManagerError

    

    init(session: URLSession = URLSession.shared, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }


    func fetchMovies(inPage page: Int, completion: @escaping FetchResult<PageEntity, APIDataManagerError>) {


        self.fetchItems(from: TheMovieDBEndpoint.popularSeries(page)) { result in

            switch result {
                case .success(let pageResult):
                    completion(.success(pageResult))

            case .failure(let error):
                completion(.failure(error))
            }

        }
    }

}
