//
//  LocalStoragreDataManager.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 18/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import UIKit
import CoreData

enum LocalStorageDataManagerError: Error{
    case notFoundError
    case notSaved
    case notDeleted
}


class LocalStorageDataManager {

    let dataController: DataController!

    init(dataController: DataController) {
        self.dataController = dataController
    }


    func fetchMoviesPage(inPage page: Int, completion: @escaping (Result<PageEntity, LocalStorageDataManagerError>)->Void ){

        print("""
                STORAGE CALL ***************************************************
            """)

        let fetchRequest: NSFetchRequest<PageEntity> = PageEntity.fetchRequest()
        let predicate = NSPredicate(format: "page == %@", NSNumber(value: page))
//        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
            fetchRequest.predicate = predicate
//            fetchRequest.sortDescriptors = [sortDescriptor]

        if let result = try? dataController.viewContext.fetch(fetchRequest) {

            if result.count != 1 { print ("MORE THAN 1 RESULT FOUND")}
            guard let page = result.last else {
                completion(.failure(.notFoundError))
                print("""
                        Not found in storage
                        ************************************************************
                    """)
                return
            }
            completion(.success(page))
            print("""
                    Pages found: \(result)
                    ************************************************************
                """)
            return


        } else {
            completion(.failure(.notFoundError))
            print("""
                    Not found in storage
                    ************************************************************
                """)
            return
        }
    }

    func fetchMovies(forPage page: PageEntity, completion: @escaping (Result<[MovieEntity], LocalStorageDataManagerError>)->Void) {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let predicate = NSPredicate(format: "page == %@", page)
            fetchRequest.predicate = predicate
//        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
//            fetchRequest.sortDescriptors = [sortDescriptor]
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            completion(.success(result))
        } else {
            completion(.failure(.notFoundError))
        }
    }

    func savePage(_ page: ResultsModel<MovieModel>, completion: @escaping FetchResult<ResultsModel<MovieModel>, LocalStorageDataManagerError>) {

        let pageEntity = PageEntity(context: dataController.viewContext)
            pageEntity.page = Int64(page.page ?? 0 )
            pageEntity.totalPages =   Int64(page.totalPages ?? 1)
            pageEntity.totalResults = Int32(page.totalResults ?? 1)
            page.results.forEach {
                let movieEntity = MovieEntity(context: dataController.viewContext)
                    movieEntity.backdropPath = $0?.backdropPath
                    movieEntity.firstAirDate = $0?.firstAirDate
                    movieEntity.genreIDS = Int16($0?.genreIDS?.first ?? 0)
                    movieEntity.id = Int64($0?.id ?? 0)
                    movieEntity.name = $0?.name ?? ""
                    movieEntity.originalLanguage = $0?.originalLanguage ?? ""
                    movieEntity.originalName = $0?.originalName ?? ""
                    movieEntity.originCountry = $0?.originCountry?.first
                    movieEntity.overview = $0?.overview ?? ""
                    movieEntity.popularity = $0?.popularity ?? 0.0
                    movieEntity.posterPath = $0?.posterPath ?? ""
                    movieEntity.voteAverage = $0?.voteAverage ?? 0
                    movieEntity.voteCount = Int16($0?.voteCount ?? 0)

                pageEntity.addToResults(movieEntity)
            }


        if dataController.viewContext.hasChanges {
            guard let _ = try? dataController.viewContext.save()
            else {
                completion(.failure(.notSaved))
                return
            }
        }
        completion(.success(page))
        return
    }

    func reloadStorage(completion: ((Result<Any, LocalStorageDataManagerError>)->Void)? = nil) {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PageEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)


        if let result = try? dataController.viewContext.execute(deleteRequest){
            print("""
                    STORAGE DELETED **********************************************************
                    \(result)
                    **************************************************************************
                """)

            completion?(.success(deleteRequest)) }
        else {  completion?(.failure(.notDeleted)) }

    }

}
