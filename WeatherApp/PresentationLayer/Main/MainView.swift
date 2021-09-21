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
    
    private let snow: SnowView = {
        let snow = SnowView()
        snow.translatesAutoresizingMaskIntoConstraints = false
        snow.particleImage = UIImage(named: "SnowFlake")
        return snow
    }()
    
    private let rain: RainView = {
        let rain = RainView()
        rain.translatesAutoresizingMaskIntoConstraints = false
        rain.particleImage = UIImage(named: "RainFlake")
        return rain
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .search
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search town...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0.8, green: 0.8, blue: 0.8, alpha: 1)]
        )
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        return textField
    }()
    
    // MARK: - Life cycle
    
    init(viewController: ViewController) {
        super.init(frame: .zero)
        searchTextField.delegate = viewController
        
        //tap doesn't work in some cases
//        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
//        addGestureRecognizer(backgroundTap)
        
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

        updateAnimation(weatherType: weather.weatherType)
    }
    
    // MARK: - Private methods
    
    private func updateAnimation(weatherType: WeatherType) {
        switch weatherType {
        case .snowy:
            rain.removeFromSuperview()
            addSubviewWithConstraints(snow)
            sendSubviewToBack(snow)
        case .rainy:
            snow.removeFromSuperview()
            addSubviewWithConstraints(rain)
            sendSubviewToBack(rain)
        default:
            break
        }
    }
    
//    @objc private func didTapBackground() {
//        endEditing(true)
//    }
    
    private func setConstraints() {
        addSubview(cityLabel)
        addSubview(dateLabel)
        addSubview(iconImage)
        addSubview(temperatureLabel)
        addSubview(descriptionLabel)
        addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            //searchTextField
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            searchTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            
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
