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
        setupConstraints()
    }
    
    func setupConstraints(){
        directorText.snp.makeConstraints{(maker) in
            maker.top.bottom.equalToSuperview()
            maker.leadingMargin.equalTo(15)
            maker.trailingMargin.equalTo(-15)
            maker.height.equalTo(38)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

