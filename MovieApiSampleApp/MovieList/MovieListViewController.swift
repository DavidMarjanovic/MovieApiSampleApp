//
//  ViewController.swift
//  tableView
//
//  Created by David Marjanović on 23/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import UIKit
import Foundation


class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var screenData: [MovieListView] = []
    let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
        setupUI()
        getData()
    }
    
    func setupUI(){
        view.addSubview(tableView)
        setupConstraints()
        setupTableView()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupTableView(){
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "Cell Class")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
    }
    
    func getData() {
        networkManager.getData(from: "https://api.themoviedb.org/3/movie/now_playing") {[unowned self] (data) in
            self.networkManager.getGenres(from: "https://api.themoviedb.org/3/genre/movie/list") { (genres) in
                guard let safeData = data else { return }
                guard let safeGenres = genres?.genres else { return }
                self.screenData = self.createScreenData(data: safeData, genres: safeGenres)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func createScreenData(data: [MovieList], genres: [Genre]) -> [MovieListView]{
        var screenData: [MovieListView] = []
        
        for movie in data{
            var genreList: [String] = []
            #warning("Release date pomoću date formattera oblikovat u oblik gdje imamo samo godinu")
            for genre in genres{
                if movie.genreIds.contains(genre.id){
                    genreList.append(genre.name)
                }
            }
            let movieListView = MovieListView(id: movie.id,
                                              title: movie.title,
                                              description: movie.overview,
                                              imageURL: movie.posterPath,
                                              year: movie.releaseDate,
                                              watched: false,
                                              favorite: false,
                                              genres: genreList)
            
            screenData.append(movieListView)
        }
        
        return screenData
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = screenData[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell Class", for: indexPath) as? MovieListCell  else {
            fatalError("The dequeued cell is not an instance of CollectionViewCell.")
        }
        cell.configureCell(movie: movie, color: UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MovieDetailsViewController(movie: screenData[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    

}
