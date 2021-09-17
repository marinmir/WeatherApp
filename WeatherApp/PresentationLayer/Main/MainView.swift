//
//  MainView.swift
//  WeatherApp
//
//  Created by Мирошниченко Марина on 17.09.2021.
//

import UIKit

class MainView: UIView {
    
    // MARK: - Private properties
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 48, weight: .heavy)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    // MARK: - Life cycle
    
    init() {
        super.init(frame: .zero)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setViews(weather: WeatherModel) {
        cityLabel.text = weather.name
        
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
        dateLabel.text = dateString
        
        let imageUrl = "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png"
        iconImage.loadImageFromURL(url: imageUrl)
        
        temperatureLabel.text = String(weather.main.temp) + "°C"
        
        descriptionLabel.text = weather.weather[0].description
    }
    
    // MARK: - Private methods
    
    private func setConstraints() {
        addSubview(cityLabel)
        addSubview(dateLabel)
        addSubview(iconImage)
        addSubview(temperatureLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            //cityLabel
            cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            cityLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
            
            //dateLabel
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: cityLabel.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //iconImage
            iconImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 50),
            iconImage.widthAnchor.constraint(equalToConstant: 150),
            iconImage.heightAnchor.constraint(equalToConstant: 150),
            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            //temperatureLabel
            temperatureLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 50),
            temperatureLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 60),
            
            //descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
