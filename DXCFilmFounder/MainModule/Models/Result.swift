//
//  Result.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 15/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import Foundation

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case fr = "fr"
}


// MARK: - Result
struct Result: Codable {
    let backdropPath, firstAirDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let name: String?
    let originCountry: [String]?
    let originalLanguage: OriginalLanguage?
    let originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

