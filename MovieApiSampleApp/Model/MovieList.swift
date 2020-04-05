//
//  MovieList.swift
//  tableView
//
//  Created by David Marjanović on 01/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

public struct MovieList: Codable{
    let id : Int
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let OriginalTitle: String
    let originalLanguage: String
    let posterPath: String
    let title: String
    let adult: Bool
    let backdropPath: String
    let video: Bool
    let voteAverage: Float
}
