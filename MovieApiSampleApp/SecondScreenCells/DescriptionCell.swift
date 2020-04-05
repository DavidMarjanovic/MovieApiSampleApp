//
//  DescriptionCell.swift
//  tableView
//
//  Created by David Marjanović on 29/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation

import UIKit

class DescriptionCell: UITableViewCell {
    
    let descText: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        title.textColor = .white
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        return title
    }()


    func configureCell(text: String){
        layer.cornerRadius = 20
        backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        selectionStyle = .none
        descText.text = text
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layoutSubviews()
        
        
    }
    
    func setupUI(){
        
        contentView.addSubview(descText)
      
        
        
        setupLayout()
    }
    
    func setupLayout(){
        
        descText.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        descText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 25).isActive = true
        descText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -25).isActive = true
        descText.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        descText.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

