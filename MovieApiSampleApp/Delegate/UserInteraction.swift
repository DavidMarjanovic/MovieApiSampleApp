//
//  UserInteraction.swift
//  tableView
//
//  Created by David Marjanović on 01/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

protocol UserInteraction: class {
    func watchedMoviePressed(with id: Int)
    func favoriteMoviePressed(with id: Int)
}
