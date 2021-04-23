//
//  URLSession+Extensions.swift
//  DXCFilmFounder
//
//  Created by Eduard Calero on 15/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import UIKit
import CoreData

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
    fileprivate func codableTask<T: Codable>(with url: URL, context: NSManagedObjectContext, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder(with: context).decode(T.self, from: data), response, nil)
        }
    }

    func pageEntityModelTask(with url: URL, context: NSManagedObjectContext, completionHandler: @escaping (PageEntity?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, context: context, completionHandler: completionHandler)
    }
}

