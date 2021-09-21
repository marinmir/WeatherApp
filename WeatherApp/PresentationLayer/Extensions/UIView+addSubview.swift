//
//  UIView+addSubview.swift
//  WeatherApp
//
//  Created by Мирошниченко Марина on 21.09.2021.
//

import UIKit

extension UIView {
    func addSubviewWithConstraints(_ subview: UIView) {
        addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
