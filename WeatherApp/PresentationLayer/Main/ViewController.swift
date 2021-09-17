//
//  ViewController.swift
//  WeatherApp
//
//  Created by Мирошниченко Марина on 09.08.2021.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let networkManager: NetworkManager
    private let locationManager = CLLocationManager()
    private lazy var _view = MainView()
    
    // MARK: - Life cycle
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        //loadWeather(city: "Москва")
    }
    
    override func loadView() {
        view = _view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Public methods
    
    
    // MARK: - Private methods
    
    private func loadWeather(city: String) {
        networkManager.fetchCurrentWeather(city: city) { [weak self] weather in
            self?.updateViewWithWeather(weather: weather)
        }
    }
    
    private func loadWeather(lat: String, lon: String) {
        networkManager.fetchCurrentLocationWeather(lat: lat, lon: lon) { [weak self] weather in
            self?.updateViewWithWeather(weather: weather)
        }
    }
    
    private func updateViewWithWeather(weather: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self._view.setViews(weather: weather)
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        
        loadWeather(lat: String(locValue.latitude), lon: String(locValue.longitude))
    }
}

