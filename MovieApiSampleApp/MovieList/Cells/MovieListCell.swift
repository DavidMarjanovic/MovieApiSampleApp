//
//  CellClass.swift
//  tableView
//
//  Created by David Marjanović on 23/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

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
        title.font = UIFont(name: "Quickand-Bold", size: 17)
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
    
    let movieImage: ImageWithGradientAndLabel = {
        let imageView = ImageWithGradientAndLabel()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let favoriteButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "notFavorite"), for: .normal)
        image.setImage(UIImage(named: "favorite"), for: .selected)
        image.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 35, height: 35))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let watchedButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "notWatched"), for: .normal)
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
    
    var favoriteClicked: ((Int)->Void)?
    var watchedClicked: ((Int)->Void)?
    
    @objc func favoriteButtonClicked(_ sender: UIButton){
        let movieId = sender.tag
        favoriteClicked?(movieId)
        if favoriteButton.isSelected == false {
            DatabaseManager.favoriteMovie(with: movieId)
            favoriteButton.isSelected = true
        } else {
            DatabaseManager.removeMovieFromFavorite(with: movieId)
            favoriteButton.isSelected = false
        }
        
    }
    @objc func watchedButtonClicked(_ sender: UIButton){
        let movieId = sender.tag
        watchedClicked?(movieId)
        if watchedButton.isSelected == false {
            DatabaseManager.watchedMovie(with: movieId)
            watchedButton.isSelected = true
        } else {
            DatabaseManager.removeMovieFromWatched(with: movieId)
            watchedButton.isSelected = false
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layoutSubviews()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked(_:)),for: .touchUpInside)
        watchedButton.addTarget(self, action: #selector(watchedButtonClicked(_:)), for: .touchUpInside)
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
        container.addSubview(favoriteButton)
        container.addSubview(watchedButton)
        setupConstraints()
    }
    
    func setupConstraints(){
        container.snp.makeConstraints{(maker) in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
        
        movieImage.snp.makeConstraints{(maker) in
            maker.top.bottom.leading.equalToSuperview()
            maker.width.height.equalTo(155)
        }
        
        favoriteButton.snp.makeConstraints{(maker) in
            maker.bottom.equalToSuperview().inset(9)
            maker.trailing.equalTo(watchedButton.snp.leading).offset(-15)
        }
        
        watchedButton.snp.makeConstraints{(maker) in
            maker.bottom.trailing.equalToSuperview().inset(ConstraintDirectionalInsets(top: 0, leading: 0, bottom: 9, trailing: 15))
            maker.width.height.equalTo(35)
        }
        
        titleText.snp.makeConstraints{(maker) in
            maker.top.trailing.equalToSuperview().inset(15)
            maker.leading.equalTo(movieImage.snp.trailing).offset(15)
        }
        
        genreLabel.snp.makeConstraints{(maker) in
            maker.top.equalTo(titleText.snp.bottom)
            maker.leading.equalTo(titleText.snp.leading)
            maker.trailing.equalToSuperview().inset(15)
        }
        
    }
    
    var grey = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
    
    func configureCell(movie: MovieListView){
        layer.borderWidth = 8
        layer.borderColor = grey.cgColor
        layer.cornerRadius = 20
        backgroundColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
        selectionStyle = .none
        movieImage.setupView(with: movie.imageURL, with: movie.year)
        //{movieImage.downloaded(from: "https://image.tmdb.org/t/p/w1280\(movie.imageURL)", contentMode: .scaleToFill)
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
        favoriteButton.tag = movie.id
        watchedButton.tag = movie.id
        favoriteButton.isSelected = movie.favorite
        watchedButton.isSelected = movie.watched
    }
    
}
