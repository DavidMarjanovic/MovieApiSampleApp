//
//  MovieDetails.swift
//  MovieApiSampleApp
//
//  Created by David Marjanović on 13/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

struct MovieDetails: Codable{
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let title: String
    let overView: String
    let posterPath: String
}

