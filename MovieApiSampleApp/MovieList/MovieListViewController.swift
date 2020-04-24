//
//  ViewController.swift
//  tableView
//
//  Created by David Marjanović on 23/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import Alamofire

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellUpdateDelegate {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 155
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let alert: UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }()
    
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var screenData: [MovieListView] = []
    let networkManager = NetworkManager()
    
    override public func viewDidLoad(){
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
        tableView.snp.makeConstraints{(maker) in
            maker.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func setupTableView(){
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "Cell Class")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
    }
    
    func getData() {
        indicator.startAnimating()
        networkManager.getData(from: "https://api.themoviedb.org/3/movie/now_playing") {[unowned self] (data) in
            
            self.networkManager.getGenres(from: "https://api.themoviedb.org/3/genre/movie/list") { (genres) in
                guard let safeData = data else {
                    self.alert.title = "Error 404"
                    self.alert.message = "Failed to get movies"
                    self.present(self.alert, animated: true, completion: nil)
                    return
                }
                guard let safeGenres = genres?.genres else {
                    self.alert.title = "Error 404"
                    self.alert.message = "Failed to get genres"
                    self.present(self.alert, animated: true, completion: nil)
                    return
                }
                self.screenData = self.createScreenData(data: safeData, genres: safeGenres)
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func createScreenData(data: [MovieList], genres: [Genre]) -> [MovieListView]{
        var screenData: [MovieListView] = []
        
        for movie in data{
            var genreList: [String] = []
            for genre in genres{
                if movie.genreIds.contains(genre.id){
                    genreList.append(genre.name)
                }
            }
            let year = DateUtils.getYearFromDate(stringDate: movie.releaseDate)
            let favorite = DatabaseManager.isMovieFavorited(with: movie.id)
            let watched = DatabaseManager.isMovieWatched(with: movie.id)
            let movieListView = MovieListView(id: movie.id,
                                              title: movie.title,
                                              description: movie.overview,
                                              imageURL: movie.posterPath,
                                              year: year,
                                              watched: watched,
                                              favorite: favorite,
                                              genres: genreList)
            
            screenData.append(movieListView)
        }
        return screenData
    }
    
    func favoritePressed(movieId: Int) {
        switchFavoriteStatus(id: movieId)
        let firstIndex = screenData.firstIndex { (movie) -> Bool in
            movie.id == movieId
        }
        let indexPath = IndexPath(row: firstIndex ?? 0, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func watchedPressed(movieId: Int) {
        switchWatchedStatus(id: movieId)
        let firstIndex = screenData.firstIndex{ (movie) -> Bool in
            movie.id == movieId
        }
        let indexPath = IndexPath(row: firstIndex ?? 0, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func switchFavoriteStatus(id: Int){
        for (index, movie) in screenData.enumerated(){
            if movie.id == id{
                var newMovie = movie
                newMovie.favorite = !newMovie.favorite
                screenData[index] = newMovie
            }
        }
    }
    
    func switchWatchedStatus(id: Int){
        for (index, movie) in screenData.enumerated(){
            if movie.id == id{
                var newMovie = movie
                newMovie.watched = !newMovie.watched
                screenData[index] = newMovie
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = screenData[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell Class", for: indexPath) as? MovieListCell  else {
            fatalError("The dequeued cell is not an instance of CollectionViewCell.")
        }
        cell.favoriteClicked = {[unowned self](id) in
            self.switchFavoriteStatus(id: id)
        }
        cell.watchedClicked = {[unowned self](id) in
            self.switchWatchedStatus(id: id)
        }
        cell.configureCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = MovieDetailsViewController(movie: screenData[indexPath.row])
        viewController.updateDelegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

