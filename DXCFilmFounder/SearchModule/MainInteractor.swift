//
//  MainInteractor.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol?
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.httpAdditionalHeaders = ["Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZmM1ZmY3Zjc2NThjMjk2ZGMxODlmOTNlNTMzY2JjOSIsInN1YiI6IjVkMzFkZmE0Y2FhYjZkMzFiMmEzZDQxYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.at6dD6L5d9a_p9tPv-A9ThvMvnCEXnlHE_yVpf-sW9M"]
        config.timeoutIntervalForRequest = 2
        return URLSession(configuration: config)
    }()
    
    
    
    var dataTask: URLSessionDataTask?
    var buffer: [URLSessionDataTask]?
    var pager: Int = 1
    
    
    func getFilmsCollection(_ query: String) {
        
        buffer?.forEach({$0.cancel()})
        buffer?.removeAll()
       
        guard query != "" else {return}
        
        pager = 1
        dataTask?.cancel()
        
    
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/4/search/movie"
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "page", value: String(pager)),
            URLQueryItem(name: "language", value: "es-ES")
        ]

            
        guard let url = components.url else { return }
        
        dataTask = session.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    print("FILMS Session Client Error: \(error)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("FILMS RESPONSE ERROR: \(response!)")
                    fatalError()
                }
                if httpResponse.statusCode == 404 {
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    print("FILMS HTTP REQUEST ERROR \(httpResponse.statusCode)")
                    
                    if let data = data  {
                        
                        if let errorBody = String(data: data, encoding: String.Encoding.utf8)
                        {
                            print("Error Body : \(errorBody)")
                        }
                    }
                    return
                }
                if let data = data {
                    
                    do {
                        
                        let page = try JSONDecoder().decode(FilmCollectionPage.self, from: data)
                        guard let results = page.results else {return}
                        DispatchQueue.main.async {
                            self.presenter?.showSearchResults(results)
                        }
                        
                        
                    } catch {
                        
                        print("FILMS PARSING ERROR: \(error)")
                        fatalError()
                        
                    }
                    
                }
            }
     
            dataTask?.resume()
        }
    
    func getFilm(_ id: Int) {
        
        //Future use
    }
    
    func getMoreFilms(_ query: String){
        
        pager += 1
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/4/search/movie"
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "page", value: String(pager)),
            URLQueryItem(name: "language", value: "es-ES")
        ]
        
        
        guard let url = components.url else { return }
        
        var request = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                print("FILMS Session Client Error: \(error)")
                fatalError()
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("FILMS RESPONSE ERROR: \(response!)")
                fatalError()
            }
            if httpResponse.statusCode == 404 {
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("FILMS HTTP REQUEST ERROR \(httpResponse.statusCode)")
                
                if let data = data  {
                    
                    if let errorBody = String(data: data, encoding: String.Encoding.utf8)
                    {
                        print("Error Body : \(errorBody)")
                    }
                }
                return
            }
            if let data = data {
                
                do {
                    
                    let page = try JSONDecoder().decode(FilmCollectionPage.self, from: data)
                    guard let results = page.results else {return}
                    DispatchQueue.main.async {
                        self.presenter?.addResults(results)
                    }
                    
                    
                } catch {
                    
                    print("FILMS PARSING ERROR: \(error)")
                    fatalError()
                    
                }
                
            }
        }
        
        buffer?.append(dataTask)
        dataTask.resume()
        
    }
    
}



