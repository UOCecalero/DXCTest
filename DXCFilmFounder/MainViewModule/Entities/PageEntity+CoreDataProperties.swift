//
//  PageEntity+CoreDataProperties.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 22/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//
//

import Foundation
import CoreData


extension PageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PageEntity> {
        return NSFetchRequest<PageEntity>(entityName: "PageEntity")
    }

    @NSManaged public var page: Int64
    @NSManaged public var totalPages: Int64
    @NSManaged public var totalResults: Int32
    @NSManaged public var results: NSOrderedSet?

}

// MARK: Generated accessors for results
extension PageEntity {

    @objc(insertObject:inResultsAtIndex:)
    @NSManaged public func insertIntoResults(_ value: MovieEntity, at idx: Int)

    @objc(removeObjectFromResultsAtIndex:)
    @NSManaged public func removeFromResults(at idx: Int)

    @objc(insertResults:atIndexes:)
    @NSManaged public func insertIntoResults(_ values: [MovieEntity], at indexes: NSIndexSet)

    @objc(removeResultsAtIndexes:)
    @NSManaged public func removeFromResults(at indexes: NSIndexSet)

    @objc(replaceObjectInResultsAtIndex:withObject:)
    @NSManaged public func replaceResults(at idx: Int, with value: MovieEntity)

    @objc(replaceResultsAtIndexes:withResults:)
    @NSManaged public func replaceResults(at indexes: NSIndexSet, with values: [MovieEntity])

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: MovieEntity)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: MovieEntity)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSOrderedSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSOrderedSet)

}
