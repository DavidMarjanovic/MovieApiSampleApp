//
//  NetworkManager.swift
//  tableView
//
//  Created by David Marjanović on 01/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit


class NetworkManager{
    let apiKey = "?api_key=06b9133cfc0285ffed0d7561358ae862"
    
    func getData(from url: String, _ completed: @escaping ([MovieList]?) -> Void) {
        guard let safeUrl = URL(string: url + apiKey) else {return}
        URLSession.shared.dataTask(with: safeUrl){data, urlResponse, error in
            guard let safeData = data, error == nil, urlResponse != nil else {
                #warning("HANDLATI ERROR")
                completed(nil)
                return
            }
            let movieList: Response<[MovieList]>? = SerilizationManager.parseData(jsonData: safeData)
            completed(movieList?.results)
        }.resume()
    }
    
    func getGenres(from url: String, _ completed: @escaping (MovieGenres?) -> Void) {
        guard let safeUrl = URL(string: url + apiKey) else {return}
        URLSession.shared.dataTask(with: safeUrl){data, urlResponse, error in
            guard let safeData = data, error == nil, urlResponse != nil else {
                #warning("HANDLATI ERROR")
                completed(nil)
                return
            }
            let movieList: MovieGenres? = SerilizationManager.parseData(jsonData: safeData)
            completed(movieList)
        }.resume()
    }
}
