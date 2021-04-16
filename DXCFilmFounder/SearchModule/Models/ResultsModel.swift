//
//  ResultsModdel.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 15/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let resultsModel = try? newJSONDecoder().decode(ResultsModel.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.resultsModelTask(with: url) { resultsModel, response, error in
//     if let resultsModel = resultsModel {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - ResultsModel
struct ResultsModel<Model: Codable>: Codable {
    let page: Int?
    let results: [Model?]
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
