//
//  MovieEntity+CoreDataProperties.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 22/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var posterImg: Data?
    @NSManaged public var backdropImg: Data?
    @NSManaged public var backdropPath: String?
    @NSManaged public var firstAirDate: String?
    @NSManaged public var genreIDS: [Int]?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalName: String?
    @NSManaged public var originCountry: [String]?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int16
    @NSManaged public var page: PageEntity?

}
