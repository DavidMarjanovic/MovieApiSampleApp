//
//  CellClass.swift
//  tableView
//
//  Created by David Marjanović on 23/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit

class MovieListCell: UITableViewCell {
    
    let titleText: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Quicksand-Bold", size: 17)
        title.textColor = .white
        return title
    }()
    
    let directorText: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Quicksand-Bold", size: 17)
        title.textColor = .white
        return title
    }()
    
    let descText: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Quicksand-Bold", size: 17)
        title.textColor = .white
        return title
    }()
    
    let genreLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Quicksand-Regular", size: 15)
        title.textColor = .white
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        return title
    }()
    
    let movieImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 155, height: 155))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    let starImage: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "emptyStar"), for: .normal)
        image.setImage(UIImage(named: "star"), for: .selected)
        image.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 35, height: 35))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let otherStarImage: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "watchedEmpty"), for: .normal)
        image.setImage(UIImage(named: "watched"), for: .selected)
        image.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 35, height: 35))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        print("button tapped")
        if starImage.isTouchInside == true {
            starImage.isSelected.toggle()
        }
        if otherStarImage.isTouchInside == true {
            otherStarImage.isSelected.toggle()
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layoutSubviews()
        
        starImage.addTarget(self, action: #selector(buttonAction),for: .touchUpInside)
        otherStarImage.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.backgroundColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
        contentView.addSubview(container)
        container.addSubview(titleText)
        container.addSubview(movieImage)
        container.addSubview(genreLabel)
        container.addSubview(starImage)
        container.addSubview(otherStarImage)
        
        
        setupLayout()
    }
    
    func setupLayout(){
        container.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        movieImage.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -220).isActive = true
        movieImage.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: 155).isActive = true
        
        starImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 101).isActive = true
        starImage.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 90).isActive = true
        starImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30).isActive = true
        starImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        otherStarImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 101).isActive = true
        otherStarImage.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 90).isActive = true
        otherStarImage.trailingAnchor.constraint(equalTo: starImage.leadingAnchor, constant: -15).isActive = true
        otherStarImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        otherStarImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        titleText.topAnchor.constraint(equalTo: container.topAnchor, constant: 15).isActive = true
        titleText.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 15).isActive = true
        titleText.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15).isActive = true
        titleText.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -118).isActive = true
        
        genreLabel.topAnchor.constraint(equalTo: titleText.bottomAnchor).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 15).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15).isActive = true
        genreLabel.bottomAnchor.constraint(equalTo: starImage.topAnchor, constant: -20).isActive = true
    }
    
    var grey = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
    
    func configureCell(movie: MovieListView, color: UIColor){
        layer.borderWidth = 8
        layer.borderColor = grey.cgColor
        layer.cornerRadius = 20
        backgroundColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
        selectionStyle = .none
        movieImage.downloaded(from: "https://image.tmdb.org/t/p/w1280\(movie.imageURL)", contentMode: .scaleToFill)
        titleText.text = movie.title
        var genreText = ""
        for (index, genre) in movie.genres.enumerated(){
            if index == 0{
                genreText = genreText + genre
            }else{
                genreText = genreText + ", \(genre)"
            }
            
        }
        genreLabel.text = genreText
    }
}
