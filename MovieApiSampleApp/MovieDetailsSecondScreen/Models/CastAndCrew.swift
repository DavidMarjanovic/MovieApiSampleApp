//
//  CastAndCrew.swift
//  MovieApiSampleApp
//
//  Created by David Marjanović on 16/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

struct CastAndCrew: Codable{
    let id: Int?
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Codable{
    let castId: Int?
    let character: String?
    let creditId: String?
    let gender: Int?
    let id: Int?
    let name: String?
    let order: Int?
    let profilePath: String?
}

struct Crew: Codable{
    let creditId: String?
    let department: String?
    let gender: Int?
    let id: Int?
    let job: String?
    let name: String?
    let profilePath: String?
}

