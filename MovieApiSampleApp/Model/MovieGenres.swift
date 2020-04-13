//
//  MovieGenres.swift
//  MovieApiSampleApp
//
//  Created by David Marjanović on 13/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation


struct MovieGenres: Codable{
    let genres: [Genre]
}


struct Genre: Codable{
    let id: Int
    let name: String
}
