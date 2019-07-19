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
    
    let apiUrl = "https://api.themoviedb.org/4/"
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZmM1ZmY3Zjc2NThjMjk2ZGMxODlmOTNlNTMzY2JjOSIsInN1YiI6IjVkMzFkZmE0Y2FhYjZkMzFiMmEzZDQxYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.at6dD6L5d9a_p9tPv-A9ThvMvnCEXnlHE_yVpf-sW9M"
    var pager: Int = 0
    
    
    func getFilmsCollection(_ query: String) {
        
        guard let url = URL(string: "\(apiUrl)search/movie?query=\(query)&include_adult=false&page=1&language=es-ES") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data:Data?, response:URLResponse?, error:Error?) in
            
            if let error = error {
                //            self.handleClientError(error)
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
                    
                    if let errorBody = try? String(data: data, encoding: String.Encoding.utf8)
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
        
        print( " \((task.currentRequest?.httpMethod)!) \(request)" )
        task.resume()
        
        
        
    }
    
    func getFilm(_ id: Int) {
        
        
    }
    
    
}

extension MainInteractor {
    
    
    
}
