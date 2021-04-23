//
//  LocalStorageDataManagerProtocol.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 20/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import Foundation
import CoreData

enum LocalStorageDataManagerError: Error{
    case notFoundError
    case contextFetchError
    case notSaved
    case notDeleted
    case cantStractPageFormURL
}

protocol LocalStorageDataManagerProtocol {

    associatedtype T: NSManagedObject, Decodable
    associatedtype E: Error

    var dataController: DataController { get set }
}

extension LocalStorageDataManagerProtocol where E == LocalStorageDataManagerError {

    func fetchPagedItems(in page: Int64, completion: @escaping FetchResult<T,E>) {

            print("""
                    STORAGE CALL ***************************************************
                """)

        let fetchRequest = T.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "page == %d", page)
            fetchRequest.predicate = predicate

        if let result = try? dataController.viewContext.fetch(fetchRequest) {

                if result.count != 1 { print ("\(result.count) RESULTS FOUND: \(result)")}
                guard let page = result.last as? T else {
                    completion(.failure(.notFoundError))
                    print("""
                            Not found in storage
                            ****************************************************************
                        """)
                    return
                }
                completion(.success(page))
                print("""
                        Items found: \(page)
                        ****************************************************************
                    """)
                return


            } else {
                completion(.failure(.contextFetchError))
                print("""
                        The page can't be retreived form local storage
                        ****************************************************************
                    """)
                return
            }

    }


    typealias ResultClousure<Err: Error> = ( (Result<Any,Err>) -> Void)

    func saveContext(completion: @escaping ResultClousure<E>) {

        if dataController.viewContext.hasChanges {
            do {
                try? dataController.viewContext.save()
                completion(.success(""))
                return
            } catch (let error) {
                print(error)
                completion(.failure(.notSaved))
                return
            }
//            guard let _ = try? dataController.viewContext.save()
//            else {
//                completion(.failure(.notSaved))
//                return
//            }
//            completion(.success(""))
//            return
        } else {
            completion(.success(""))
            return
        }
    }

    func reloadStorage(completion: ResultClousure<E>? = nil) {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)


        if let result = try? dataController.viewContext.execute(deleteRequest){
            print("""
                    STORAGE DELETED ************************************************
                    \(result)
                    ****************************************************************
                """)

            completion?(.success("")) }
        else {  completion?(.failure(.notDeleted)) }

    }

}
