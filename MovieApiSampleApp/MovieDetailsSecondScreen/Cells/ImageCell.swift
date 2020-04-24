//
//  ImageCell.swift
//  tableView
//
//  Created by David Marjanović on 28/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit

class ImageCell: UITableViewCell {
    
    weak var backButtonDelegate: BackButtonDelegate?
    
    let movieImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 375, height: 255))
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
    
    let backButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "Vector"), for: .normal)
        image.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 35, height: 35))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func configureCell(image: String, movie: MovieListView){
        backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        selectionStyle = .none
        movieImage.loadImage(with: image)
        layer.cornerRadius = 20
        favoriteButton.tag = movie.id
        watchedButton.tag = movie.id
        favoriteButton.isSelected = movie.favorite
        watchedButton.isSelected = movie.watched
    }
    
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
    
    var viewController = MovieListViewController()
    
    @objc func back(sender: UIButton!) {
        backButtonDelegate?.popViewController()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layoutSubviews()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked(_:)),for: .touchUpInside)
        watchedButton.addTarget(self, action: #selector(watchedButtonClicked(_:)), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    func setupUI(){
        contentView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        contentView.addSubview(movieImage)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(watchedButton)
        contentView.addSubview(backButton)
        setupConstraints()
    }
    
    func setupConstraints(){
        movieImage.snp.makeConstraints{(maker) in
            maker.top.bottom.leading.trailing.equalToSuperview()
            maker.height.equalTo(255)
        }
        
        watchedButton.snp.makeConstraints{(maker) in
            maker.top.width.height.equalTo(35)
            maker.trailing.equalToSuperview().offset(-15)
        }
        
        favoriteButton.snp.makeConstraints{(maker) in
            maker.top.width.height.equalTo(35)
            maker.trailing.equalToSuperview().offset(-65)
        }
        
        backButton.snp.makeConstraints{(maker) in
            maker.top.height.width.equalTo(35)
            maker.leading.equalToSuperview().offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
