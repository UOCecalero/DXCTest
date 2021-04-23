//
//  MainDataManagerProtocol.swift
//  DXCFilmFounder
//
//  Created by Eduard Calero on 20/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import Foundation

enum APIDataManagerError: Error {
    case invalidStatusCode(Int, String?)
    case notFoundError
    case JSONdecodingError
    case httpResponseError(Error?)
    case unexpectedPage
    case noMorePages
    case uknown(Error?)
}

typealias FetchResult<T: Decodable, E: Error> = ((Result<T, E>)->())

protocol  MainDataManagerProtocol {

    associatedtype T: Decodable
    associatedtype E: Error

    var session: URLSession { get }
    var decoder: JSONDecoder { get }

}

extension MainDataManagerProtocol {

    func fetchItems(from requestBuilder: RequestBuilder, completion: @escaping FetchResult<T,E>) where E == APIDataManagerError {

        print("""
                    API CALL *************************************************************
                    \(requestBuilder.urlRequest.description)
            """)

        session.dataTask(with: requestBuilder.urlRequest) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.uknown(error)))
                    print("""
                        Result failed: Uknown
                        **********************************************************************
                        """)
                }
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.httpResponseError(nil)))
                    print("""
                        Result failed: Http responseError
                        **********************************************************************
                        """)
                }
                return
            }

            if httpResponse.statusCode == 404 {
                DispatchQueue.main.async {
                    completion(.failure(.notFoundError))
                    print("""
                        Result failed: 404 NOT FOUND
                        **********************************************************************
                        """)
                }
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                if let data = data, let stringError = String(data: data, encoding: String.Encoding.utf8)  {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidStatusCode(httpResponse.statusCode, stringError)))
                        print("""
                            Result failed: invalid status code
                            **********************************************************************
                            """)
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidStatusCode(httpResponse.statusCode, nil)))
                        print("""
                            Result failed: invalid status code
                            **********************************************************************
                            """)
                    }
                    return
                }
            }


            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.uknown(nil)))
                    print("""
                        Result failed: uknown
                        **********************************************************************
                        """)
                }
                return
            }

            guard let resultsModel = try? self.decoder.decode(T.self, from: data)
            else {
                DispatchQueue.main.async {
                completion(.failure(.JSONdecodingError))
                print("""
                    Result failed: JsonDecodingError
                    **********************************************************************
                    """)
                }
                return
            }

            DispatchQueue.main.async {
                completion(.success(resultsModel ))
                print("""
                    Success: \(resultsModel)
                    **********************************************************************
                    """)
                
                return
            }


        }.resume()

    }
}
