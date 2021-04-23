//
//  GenereEntity+CoreDataProperties.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 22/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//
//

import Foundation
import CoreData


extension GenereEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenereEntity> {
        return NSFetchRequest<GenereEntity>(entityName: "GenereEntity")
    }

    @NSManaged public var genreIDS: String?
    @NSManaged public var movie: MovieEntity?

}
