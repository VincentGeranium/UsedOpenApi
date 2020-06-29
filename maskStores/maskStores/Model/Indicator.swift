//
//  Indicator.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/29.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import Foundation
import UIKit

struct Indicator {
    let backgroundView: UIView = UIView()
    let loadingTextLabel: UILabel = UILabel()
    let indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    let viewForIndicator: UIView = UIView()
    let targetView: UIView
    
    func activateIndicator(_ loadingText: String) {
        backgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        targetView.addSubview(backgroundView)
        
        
//        NSLayoutConstraint.activate([
//            viewForIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
//            viewForIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
//            viewForIndicator.widthAnchor.constraint(equalToConstant: 150),
//            viewForIndicator.heightAnchor.constraint(equalToConstant: 150),
//        ])
//
//        viewForIndicator.backgroundColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 0.8)
//        viewForIndicator.layer.cornerRadius = 10
//        backgroundView.addSubview(viewForIndicator)
//
//        NSLayoutConstraint.activate([
//            indicatorView.centerYAnchor.constraint(equalTo: viewForIndicator.centerYAnchor),
//            indicatorView.topAnchor.constraint(equalTo: viewForIndicator.topAnchor, constant: 10),
//            indicatorView.widthAnchor.constraint(equalToConstant: 100),
//            indicatorView.heightAnchor.constraint(equalToConstant: 100),
//        ])
//
//        indicatorView.hidesWhenStopped = true
//        indicatorView.style = .large
//        indicatorView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
//        viewForIndicator.addSubview(indicatorView)
//
//        NSLayoutConstraint.activate([
//            loadingTextLabel.centerYAnchor.constraint(equalTo: viewForIndicator.centerYAnchor),
//            loadingTextLabel.topAnchor.constraint(equalTo: indicatorView.bottomAnchor, constant: 10),
//            loadingTextLabel.widthAnchor.constraint(equalToConstant: 100),
//            loadingTextLabel.heightAnchor.constraint(equalToConstant: 30),
//        ])
//
//        loadingTextLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
//        loadingTextLabel.text = "\(loadingText)"
//        loadingTextLabel.textColor = .black
//        loadingTextLabel.sizeToFit()
//        viewForIndicator.addSubview(loadingTextLabel)
        
        indicatorView.startAnimating()
    }
    
    func stopIndicator() {
        backgroundView.removeFromSuperview()
        viewForIndicator.removeFromSuperview()
        indicatorView.stopAnimating()
        loadingTextLabel.removeFromSuperview()
    }
 
    
}
