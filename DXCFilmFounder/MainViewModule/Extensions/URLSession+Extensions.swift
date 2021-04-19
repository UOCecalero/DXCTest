//
//  URLSession+Extensions.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 15/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import UIKit

// To read values from URLs:
//
//   let task = URLSession.shared.resultTask(with: url) { result, response, error in
//     if let result = result {
//       ...
//     }
//   }
//   task.resume()

// MARK: - URLSession response handlers
extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func resultsMovieModelTask(with url: URL, completionHandler: @escaping (ResultsModel<MovieModel>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

extension UIViewController {

    static func generatedIntanceViewController<T: UIViewController>(storyBoardName: String? = nil) -> T {
        let nameViewController: String = String(describing: T.self)

        let storyboard = UIStoryboard(
            name: storyBoardName ?? nameViewController,
            bundle: Bundle.main
        )

        guard let viewController: T = storyboard.instantiateViewController(withIdentifier: nameViewController) as? T else {
            fatalError("Storyboard full screen error not has been initialized")
        }

        return viewController
    }
}
