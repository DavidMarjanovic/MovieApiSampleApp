//
//  DatabaseManager.swift
//  tableView
//
//  Created by David Marjanović on 01/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

struct DatabaseKeys{
    static let watched = "watched"
    static let favorite = "favorite"
}

class DatabaseManager{
    
    static let defaults = UserDefaults.standard
    
    static func isMovieWatched(with id: Int) -> Bool{
        guard let watchedIds = defaults.array(forKey: DatabaseKeys.watched) as? [Int] else {return false}
        return watchedIds.contains(id)
    }
    
    static func isMovieFavorited(with id: Int) -> Bool{
        guard let favoriteIds = defaults.array(forKey: DatabaseKeys.favorite) as? [Int] else {return false}
        return favoriteIds.contains(id)
        }
    
    static func watchedMovie(with id: Int) {
        guard var watchedIds = defaults.array(forKey: DatabaseKeys.watched) as? [Int]
            else {
                defaults.set([id], forKey: DatabaseKeys.watched)
                return
        }
        watchedIds.append(id)
        defaults.set(watchedIds, forKey: DatabaseKeys.watched)
        defaults.synchronize()
    }
    
    static func favoriteMovie(with id: Int){
        guard var favoriteIds = defaults.array(forKey: DatabaseKeys.favorite) as?  [Int]
            else {
                defaults.set(id, forKey: DatabaseKeys.favorite)
                return
        }
        favoriteIds.append(id)
        defaults.set(favoriteIds, forKey: DatabaseKeys.favorite)
        defaults.synchronize()
    }
    
    static func removeMovieFromWatched(with id: Int){
        guard var watchedIds = defaults.array(forKey: DatabaseKeys.watched) as? [Int]
            else {return}
        watchedIds.removeAll { (data) ->  Bool in return data == id}
        defaults.set(watchedIds, forKey: DatabaseKeys.watched)
    }
    
    static func removeMovieFromFavorite(with id: Int){
        guard var favoriteIds = defaults.array(forKey: DatabaseKeys.favorite) as? [Int]
            else {return}
        favoriteIds.removeAll { (data) -> Bool in return data == id}
        defaults.set(favoriteIds, forKey: DatabaseKeys.favorite)
        defaults.synchronize()
    }
    
    
}
    

