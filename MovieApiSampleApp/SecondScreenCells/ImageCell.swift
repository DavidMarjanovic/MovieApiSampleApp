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
    
    let backButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "vector"), for: .normal)
        image.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 35, height: 35))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    


    func configureCell(image: UIImage){
        backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        selectionStyle = .none
        movieImage.image = image
        layer.cornerRadius = 20
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("button tapped")
        if starImage.isTouchInside == true {
            starImage.isSelected.toggle()
        }
        if otherStarImage.isTouchInside == true {
            otherStarImage.isSelected.toggle()
        }
    }
    
    @objc func back(sender: UIButton!) {
        print("button tapped")
        backButtonDelegate?.popViewController()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layoutSubviews()
        
        starImage.addTarget(self, action: #selector(buttonAction),for: .touchUpInside)
        otherStarImage.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    func setupUI(){
        contentView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        contentView.addSubview(movieImage)
        contentView.addSubview(starImage)
        contentView.addSubview(otherStarImage)
        contentView.addSubview(backButton)
        
        
        setupLayout()
    }
    
    func setupLayout(){
        
        movieImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        movieImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: 375).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 255).isActive = true
        
        starImage.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 35).isActive = true
        starImage.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 325).isActive = true
        starImage.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -15).isActive = true
        starImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        otherStarImage.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 35).isActive = true
        otherStarImage.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 275).isActive = true
        otherStarImage.trailingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: -65).isActive = true
        otherStarImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        otherStarImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        backButton.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 40).isActive = true
        backButton.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 20).isActive = true
        backButton.trailingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: -330).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
