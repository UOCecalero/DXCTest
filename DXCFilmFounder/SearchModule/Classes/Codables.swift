//
//  Film.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import Foundation

struct FilmCollectionPage: Codable {
    
    let page: Int?  //1,
    let total_results: Int? //2273,
    let total_pages: Int? //114,
    let results: [Film]?
}

struct Film: Codable {
    
    let popularity: Double?          //7.206
    let id: Int64                   //41110,
    let video: Bool?                 //false,
    let vote_count: Int?             //151,
    let vote_average: Double?           //7,
    let title: String               //"Yo soy el amor",
    let release_date: String          //"2009-09-05",
    let original_language: String   //"it",
    let original_title: String?      //"Io sono l'amore",
    let genre_ids: [Int]?            //[18, 10749],
    let backdrop_path: String?       //"/zqwSA5iMoOVSHmioQi9MkySUumh.jpg",
    let adult: Bool?                 //false,
    let overview:  String?           //"La familia Recchi pertenece ... muy alto.",
    let poster_path: String?         //"/oPxRjbXA90tNLZAERpCQbRPSXQx.jpg"
    
    
}
