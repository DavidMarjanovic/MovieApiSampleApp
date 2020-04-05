//
//  Response.swift
//  tableView
//
//  Created by David Marjanović on 02/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

public struct Response<T: Codable>: Codable {
    let results: T
}
