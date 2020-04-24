//
//  CellUpdateDelegate.swift
//  MovieApiSampleApp
//
//  Created by David Marjanović on 22/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit

protocol CellUpdateDelegate: class {
    func favoritePressed(movieId: Int)
    func watchedPressed(movieId: Int)
}
