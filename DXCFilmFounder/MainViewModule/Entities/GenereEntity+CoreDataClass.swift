//
//  GenereEntity+CoreDataClass.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 20/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//
//

import Foundation
import CoreData


public class GenereEntity: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
    }

    public required convenience init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genreIDS = try container.decode(String.self, forKey: .genreIDS)

//        let genreData = try container.decodeIfPresent([String].self, forKey: .genreIDS) ?? []
//        let genreArray = genreData.map { gen -> String in
//            let genre = GenereEntity(context: context)
//                genre.genreIDS = gen
//                genre.movie = self
//                return genre
//        }
//        self.genreIDS = Set(genreArray)
      }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genreIDS, forKey: .genreIDS)
    }

}
