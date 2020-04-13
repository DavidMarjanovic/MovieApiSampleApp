//
//  descriptionScreen.swift
//  tableView
//
//  Created by David Marjanović on 26/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit


class MovieDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BackButtonDelegate {
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    var screenData = [MovieCellItem]()

    let movie: MovieListView
    init(movie: MovieListView) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createScreenData(movie: MovieListView) -> [MovieCellItem] {
        
        var screenData: [MovieCellItem] = []
        #warning("Kasnije prepraviti s novim modelima")
//        screenData.append(MovieCellItem(type: .image, data: movie.image))
//        screenData.append(MovieCellItem(type: .title, data: movie.title))
//        screenData.append(MovieCellItem(type: .genre, data: movie.genre))
//        screenData.append(MovieCellItem(type: .director, data: movie.director))
//        screenData.append(MovieCellItem(type: .description, data: movie.description))
        
        return screenData
    }
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = screenData[indexPath.row]
        switch item.type {
        case .image:
            guard let safeData = item.data as? UIImage else {
                return UITableViewCell()
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? ImageCell  else {
                fatalError("The dequeued cell is not an instance of CollectionViewCell.")
            }
            cell.backButtonDelegate = self
            cell.configureCell(image: safeData)
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
            guard let safeData = item.data as? String else {
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        view.addSubview(tableView)
        self.screenData = createScreenData(movie: self.movie)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupTableView()
        setupConstraints()
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
            
        ])
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
    
    
}



