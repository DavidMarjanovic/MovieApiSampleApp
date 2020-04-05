//
//  ViewController.swift
//  tableView
//
//  Created by David Marjanović on 23/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    let movie1 = Movie(
        title: "Little Women", genre: "Drama", image: UIImage(named: "Image")!, director: "john doe", description: "A movie about women who are little."
    )
    
    let movie2 = Movie(title: "Inside out", genre: "Animation, comedy, adventure", image: UIImage(named: "Image-1")!, director: "DIRECTOR: Pete Dokter", description: "After young Riley is uprooted from her Midwest life and moved to San Francisco, her emotions - Joy, Fear, Anger, Disgust and Sadness - conflict on how best to navigate a new city, house, and school.")
    
    lazy var movies = [
        movie1,
        movie2
    ]
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
        setupUI()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell Class", for: indexPath) as? CellClass  else {
            fatalError("The dequeued cell is not an instance of CollectionViewCell.")
        }
        cell.configureCell(movie: movie, color: UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = descriptionScreen(movie: movies[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
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
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell Class")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
    }
}



