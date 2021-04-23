//
//  MovieEntity+CoreDataClass.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 20/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//
//

import UIKit
import CoreData


public class MovieEntity: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case id, name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIDS = "genre_ids"
        case originCountry = "origin_country"
    }

    public required convenience init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.firstAirDate = try container.decodeIfPresent(String.self, forKey: .firstAirDate)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        self.originalName = try container.decodeIfPresent(String.self, forKey: .originalName)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int16.self, forKey: .voteCount)

        self.genreIDS = try container.decodeIfPresent([Int].self, forKey: .genreIDS)
        self.originCountry = try container.decodeIfPresent([String].self, forKey: .originCountry)

        if let image = self.posterPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)") {
                if let data = try? Data(contentsOf: url)
                {
                    self.posterImg = data
                }
            }
      }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(firstAirDate, forKey: .firstAirDate)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(originalName, forKey: .originalName)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(genreIDS, forKey: .genreIDS)
        try container.encode(originCountry, forKey: .originCountry)
    }

}
