//
//  OriginCountryEntity+CoreDataProperties.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 20/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//
//

import Foundation
import CoreData


extension OriginCountryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OriginCountryEntity> {
        return NSFetchRequest<OriginCountryEntity>(entityName: "OriginCountryEntity")
    }

    @NSManaged public var originCountry: String?
    @NSManaged public var movie: MovieEntity?

}
