//
//  itemsAndTypes.swift
//  tableView
//
//  Created by David Marjanović on 28/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit

enum MovieItemType{
    case image
    case title
    case genre
    case director
    case description
}

struct MovieCellItem{
    let type: MovieItemType
    let data: Any
}


