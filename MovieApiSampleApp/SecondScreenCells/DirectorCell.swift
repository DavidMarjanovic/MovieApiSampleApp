//
//  DirectorCell.swift
//  tableView
//
//  Created by David Marjanović on 29/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit


class DirectorCell: UITableViewCell {
    
    let directorText: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        title.textColor = .white
        return title
    }()


    func configureCell(text: String){
        layer.cornerRadius = 20
        backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        selectionStyle = .none
        directorText.text = text
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layoutSubviews()
        
        
    }
    
    func setupUI(){
        contentView.addSubview(directorText)
      
        
        
        setupLayout()
    }
    
    func setupLayout(){
        
        directorText.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        directorText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 25).isActive = true
        directorText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -25).isActive = true
        directorText.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        directorText.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

