//
//  DataController.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 18/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import Foundation
import CoreData

class DataController {

    let persistentContainer:NSPersistentContainer

    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }

    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
}
