//
//  ImageWithYear.swift
//  MovieApiSampleApp
//
//  Created by David Marjanović on 14/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ImageWithGradientAndLabel: UIView {
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Quicksand-Medium", size: 21)
        return label
    }()
    
    var gradientBackground: GradientView = {
        let gradientView = GradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupView(with imageURL: String, with year: String){
        loadImage(with: imageURL)
        label.text  = year
    }
    
    private func loadImage(with imageURL: String){
        image.image = UIImage(systemName: "square.and.pencil")
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w1280"+imageURL) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let safeImage = UIImage(data: data)
                    DispatchQueue.main.async {[weak self] in
                        self?.image.image = safeImage
                    }
                }
            }
        }
    }
}

private extension ImageWithGradientAndLabel{
    func setupUI(){
        addSubview(image)
        addSubview(gradientBackground)
        addSubview(label)
        setupConstraints()
    }
    
    func setupConstraints(){
        image.snp.makeConstraints{(maker) in
            maker.leading.trailing.top.bottom.equalTo(self)
        }
        
        label.snp.makeConstraints{(maker) in
            maker.bottom.equalTo(image).offset(-8)
            maker.centerX.equalTo(image)
        }
        
        gradientBackground.snp.makeConstraints{(maker) in
            maker.leading.trailing.top.bottom.equalTo(image)
        }
    }
}
