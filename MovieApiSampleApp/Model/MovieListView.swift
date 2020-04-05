//
//  MovieListView.swift
//  tableView
//
//  Created by David Marjanović on 02/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

struct MovieListView {
    let id: Int
    let title: String
    let description: String
    let imageURL: String
    let year: String
    let watched: Bool
    let favorite: Bool
    
    init(id: Int, title: String, description: String, imageURL: String, year: String, watched: Bool, favorite: Bool){
        self.id = id
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.year = year
        self.watched = watched
        self.favorite = favorite
    }
}
