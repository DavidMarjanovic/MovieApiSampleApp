//
//  GradientView.swift
//  MovieApiSampleApp
//
//  Created by David Marjanović on 14/04/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    private let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(named: "startGradientColor")!.cgColor, UIColor(named: "endGradientColor")!.cgColor]
        gradient.locations = [0.0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.cornerRadius = 20
        return gradient
    }()
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.gradient.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        self.gradient.frame = self.bounds
        self.layer.insertSublayer(self.gradient, at: 0)
    }
}
