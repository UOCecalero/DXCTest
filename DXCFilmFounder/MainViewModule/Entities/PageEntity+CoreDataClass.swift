//
//  PageEntity+CoreDataClass.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 20/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//
//

import Foundation
import CoreData


public class PageEntity: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    public required convenience init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int64.self, forKey: .page)
        self.totalPages = try container.decode(Int64.self, forKey: .totalPages)
        self.totalResults = try container.decode(Int32.self, forKey: .totalResults)


        let movieEntitySet = try container.decode(Set<MovieEntity>.self, forKey: .results)
        var moviesArray = [MovieEntity]()

        for movieEntity in movieEntitySet {
            moviesArray.append(movieEntity)
        }

        let orderedSet = NSOrderedSet(array: moviesArray )
        self.results = orderedSet
      }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(totalPages, forKey: .totalPages)
        try container.encode(totalResults, forKey: .totalResults)
        try container.encode(results as! Set<MovieEntity>, forKey: .results)
    }

}
