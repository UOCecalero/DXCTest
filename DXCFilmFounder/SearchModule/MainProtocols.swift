//
//  MainProtocols.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
    
    var presenter: MainPresenterProtocol?   { get set }

    func refresh()
    func showSpinner()
    func showAlert(title: String, message: String?)
}

protocol MainPresenterProtocol: class {
    
    var view: MainViewProtocol?             { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol?         { get set }

    var itemsArray: [MovieModel]            { get set }


    //MARK: View -> Prsenter
    func viewDidAppear()
    func viewDidLoad()
    func didSelectRow(_ indexpath: IndexPath)

}

extension MainPresenterProtocol {
    func viewDidLoad() {}
}

typealias FetchResult<T: Decodable, E: Error> = ((Result<T, E>)->())

protocol MainInteractorProtocol: class {
    
    var presenter: MainPresenterProtocol?      { get set }

    func getPopularSeries(completion: @escaping (Result<[MovieModel], MainInteractorError>)->Void) 

}

enum APIDataManagerError: Error {
    case invalidStatusCode(Int, String?)
    case notFoundError
    case JSONdecodingError
    case httpResponseError(Error?)
    case unexpectedPage
    case noMorePages
    case uknown(Error?)
}

protocol  MainDataManagerProtocol {

    associatedtype T: Decodable
    associatedtype E: Error

    var session: URLSession { get set }

}

extension MainDataManagerProtocol {

    func fetchItems(from requestBuilder: RequestBuilder, completion: @escaping FetchResult<T,E>) where E == APIDataManagerError {

        session.dataTask(with: requestBuilder.urlRequest) { data, response, error in
//            defer { self.dataTask = nil }

            if let error = error {
                completion(.failure(.uknown(error)))
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.httpResponseError(nil)))
                return
            }

            if httpResponse.statusCode == 404 {
                completion(.failure(.notFoundError))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                if let data = data, let stringError = String(data: data, encoding: String.Encoding.utf8)  {
                    completion(.failure(.invalidStatusCode(httpResponse.statusCode, stringError)))
                    return
                } else {
                    completion(.failure(.invalidStatusCode(httpResponse.statusCode, nil)))
                    return
                }
            }


            guard let data = data else { completion(.failure(.uknown(nil))); return}

            guard let resultsModel = try? newJSONDecoder().decode(T.self, from: data) else { completion(.failure(.JSONdecodingError)); return }
            DispatchQueue.main.async {
                completion(.success(resultsModel))
                return
            }

        }.resume()

    }
}


protocol MainRouterProtocol: class {
    
    static func createMainViewController() -> UIViewController
    
    func goToDetail(from view: MainViewProtocol, with item: MovieModel)
    
}
