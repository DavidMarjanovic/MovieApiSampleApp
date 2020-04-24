//
//  DatabaseManager.swift
//  tableView
//
//  Created by David Marjanović on 01/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

enum DatabaseKeys: String {
    case watched = "watched"
    case favorite = "favorite"
    case reload = "reload"
    case genre = "genre"
    case director = "director"
}

class DatabaseManager{
    
    static let defaults = UserDefaults.standard
    
    static func isMovieWatched(with id: Int) -> Bool{
        guard let watchedIds = defaults.array(forKey: DatabaseKeys.watched.rawValue) as? [Int] else {return false}
        return watchedIds.contains(id)
    }
    
    static func isMovieFavorited(with id: Int) -> Bool{
        guard let favoriteIds = defaults.array(forKey: DatabaseKeys.favorite.rawValue) as? [Int] else {return false}
        return favoriteIds.contains(id)
    }
    
    static func watchedMovie(with id: Int) {
        guard var watchedIds = defaults.array(forKey: DatabaseKeys.watched.rawValue) as? [Int]
            else {
                defaults.set([id], forKey: DatabaseKeys.watched.rawValue)
                return
        }
        watchedIds.append(id)
        defaults.set(watchedIds, forKey: DatabaseKeys.watched.rawValue)
    }
    
    static func favoriteMovie(with id: Int){
        guard var favoriteIds = defaults.array(forKey: DatabaseKeys.favorite.rawValue) as?  [Int]
            else {
                defaults.set([id], forKey: DatabaseKeys.favorite.rawValue)
                return
        }
        favoriteIds.append(id)
        defaults.set(favoriteIds, forKey: DatabaseKeys.favorite.rawValue)
    }
    
    static func removeMovieFromWatched(with id: Int){
        guard var watchedIds = defaults.array(forKey: DatabaseKeys.watched.rawValue) as? [Int]
            else {return}
        watchedIds.removeAll { (data) ->  Bool in return data == id}
        defaults.set(watchedIds, forKey: DatabaseKeys.watched.rawValue)
    }
    
    static func removeMovieFromFavorite(with id: Int){
        guard var favoriteIds = defaults.array(forKey: DatabaseKeys.favorite.rawValue) as? [Int]
            else {return}
        favoriteIds.removeAll { (data) -> Bool in return data == id}
        defaults.set(favoriteIds, forKey: DatabaseKeys.favorite.rawValue)
    }
    
    static func isReloadNeeded() -> Int{
        let reloadId = defaults.integer(forKey: DatabaseKeys.reload.rawValue)
        return reloadId
    }
    static func cellToReload(id: Int) {
        defaults.set(id, forKey: DatabaseKeys.reload.rawValue)
    }
    static func insertGenres(genres: [Genre]){
        guard defaults.array(forKey: DatabaseKeys.genre.rawValue) as? [Genre] != nil else{
            defaults.set(object: genres, forKey: DatabaseKeys.genre.rawValue)
            return
        }
    }
    static func getGenres() -> [Genre]{
        guard let movieGenres = defaults.object([Genre].self, with: DatabaseKeys.genre.rawValue) else{
            return [Genre]()
        }
        return movieGenres
    }
    
    static func getDirector(movieId: Int) -> MovieDirector{
        guard let movieDirectors = defaults.object([MovieDirector].self, with: DatabaseKeys.director.rawValue) else{
            return MovieDirector(name: "not found", movieId: movieId)
        }
        let index = movieDirectors.firstIndex(where: {(direc) in direc.movieId == movieId })!
        return movieDirectors[index]
    }
}

//MARK: Extension
extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}






