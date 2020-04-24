//
//  descriptionScreen.swift
//  tableView
//
//  Created by David Marjanović on 26/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BackButtonDelegate{
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let alert: UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }()
    
    weak var updateDelegate: CellUpdateDelegate?
    
    var viewController = MovieListViewController()
    
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    let networkManager = NetworkManager()
    var screenData = [MovieCellItem]()
    var movie: MovieListView
    
    init(movie: MovieListView) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createScreenData(movie: MovieListView, director: CastAndCrew) -> [MovieCellItem] {
        var screenData: [MovieCellItem] = []
        
        screenData.append(MovieCellItem(type: .image, data: movie.imageURL))
        screenData.append(MovieCellItem(type: .title, data: movie.title))
        screenData.append(MovieCellItem(type: .genre, data: movie.genres))
        for person in director.crew{
            if person.job == "Director"{
                screenData.append(MovieCellItem(type: .director, data: person.name!))
            }
        }
        screenData.append(MovieCellItem(type: .description, data: movie.description))
        return screenData
    }
    
    func getDirector(){
        networkManager.getDirector(from: "https://api.themoviedb.org/3/movie/\(movie.id)/credits", {[unowned self](director) in
            guard let safeDirector = director else {
                self.alert.title = "Error 404"
                self.alert.message = "Failed to get director"
                self.present(self.alert, animated: true, completion: nil)
                return
            }
            self.screenData = self.createScreenData(movie: self.movie, director: safeDirector)
            DispatchQueue.main.async {[unowned self] in
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        view.addSubview(tableView)
        //self.screenData = createScreenData(movie: self.movie)
        navigationController?.setNavigationBarHidden(true, animated: true)
        getDirector()
        setupTableView()
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints{(maker) in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setupTableView(){
        tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.register(TitleCell.self, forCellReuseIdentifier: "TitleCell")
        tableView.register(GenreCell.self, forCellReuseIdentifier: "GenreCell")
        tableView.register(DirectorCell.self, forCellReuseIdentifier: "DirectorCell")
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: "DescriptionCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = screenData[indexPath.row]
        switch item.type {
        case .image:
            guard let safeData = item.data as? String else {
                return UITableViewCell()
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? ImageCell  else {
                fatalError("The dequeued cell is not an instance of CollectionViewCell.")
            }
            cell.favoriteClicked = {[unowned self] (movieId) in
                self.updateDelegate?.favoritePressed(movieId: movieId)
            }
            cell.watchedClicked = {[unowned self] (movieId) in
                self.updateDelegate?.watchedPressed(movieId: movieId)
            }
            cell.backButtonDelegate = self
            cell.configureCell(image: safeData, movie: movie)
            return cell
        case .title:
            guard let safeData = item.data as? String else {
                return UITableViewCell()
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell  else {
                fatalError("The dequeued cell is not an instance of CollectionViewCell.")
            }
            cell.configureCell(text: safeData)
            return cell
        case .genre:
            guard let safeData = item.data as? [String] else {
                return UITableViewCell()
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as? GenreCell  else {
                fatalError("The dequeued cell is not an instance of CollectionViewCell.")
            }
            cell.configureCell(text: safeData)
            return cell
        case .director:
            guard let safeData = item.data as? String else {
                return UITableViewCell()
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DirectorCell", for: indexPath) as? DirectorCell  else {
                fatalError("The dequeued cell is not an instance of CollectionViewCell.")
            }
            cell.configureCell(text: safeData)
            return cell
        case .description:
            guard let safeData = item.data as? String else {
                return UITableViewCell()
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionCell  else {
                fatalError("The dequeued cell is not an instance of CollectionViewCell.")
            }
            cell.configureCell(text: safeData)
            return cell
        }
    }
    
}



