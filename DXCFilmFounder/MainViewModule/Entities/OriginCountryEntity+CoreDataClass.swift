//
//  OriginCountryEntity+CoreDataClass.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 20/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//
//

import Foundation
import CoreData


public class OriginCountryEntity: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case originCountry = "origin_country"
    }

    public required convenience init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext
        else {  throw DecoderConfigurationError.missingManagedObjectContext }
        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.originCountry = try container.decodeIfPresent(String.self, forKey: .originCountry)
      }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(originCountry, forKey: .originCountry)

    }

}
