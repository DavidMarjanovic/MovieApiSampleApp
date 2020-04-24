//
//  NetworkManager.swift
//  tableView
//
//  Created by David Marjanović on 01/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class NetworkManager{
    let apiKey = "?api_key=06b9133cfc0285ffed0d7561358ae862"
    
    func getData(from url: String,_ completed: @escaping([MovieList]?) -> Void){
        AF.request(url + apiKey).validate().responseDecodable(of: Response<[MovieList]>.self, decoder: SerializationManager.jsonDecoder ) { (movieResponse) in
            do {
                let response = try movieResponse.result.get()
                completed(response.results)
            }catch let error{
                debugPrint("Error happened: ", error.localizedDescription)
                completed(nil)
            }
        }
    }
    
    func getGenres(from url: String,_ completed: @escaping(MovieGenres?) -> Void){
        AF.request(url + apiKey).validate().responseDecodable(of: MovieGenres.self, decoder: SerializationManager.jsonDecoder) { (genreResponse) in
            do {
                let response = try genreResponse.result.get()
                completed(response)
            }catch {
                debugPrint("Error happened: ", error.localizedDescription)
                completed(nil)
            }
        }
    }
    
    func getDirector(from url: String,_ completed: @escaping(CastAndCrew?) -> Void){
        AF.request(url + apiKey).validate().responseDecodable(of: CastAndCrew
            .self, decoder: SerializationManager.jsonDecoder) { (genreResponse) in
                do {
                    let response = try genreResponse.result.get()
                    completed(response)
                }catch {
                    debugPrint("Error happened: ", error.localizedDescription)
                    completed(nil)
                }
        }
    }
    
}
