//
//  TitleCell.swift
//  tableView
//
//  Created by David Marjanović on 29/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit

class TitleCell: UITableViewCell {
    
    let titleText: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 29, weight: .medium)
        title.textColor = .white
        return title
    }()
    
    func configureCell(text: String){
        layer.cornerRadius = 20
        backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        selectionStyle = .none
        titleText.text = text
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layoutSubviews()
    }
    
    func setupUI(){
        contentView.addSubview(titleText)
        setupConstraints()
    }
    
    func setupConstraints(){
        titleText.snp.makeConstraints{(maker) in
            maker.top.bottom.equalToSuperview()
            maker.leadingMargin.equalTo(15)
            maker.trailingMargin.equalTo(-15)
            maker.height.equalTo(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

