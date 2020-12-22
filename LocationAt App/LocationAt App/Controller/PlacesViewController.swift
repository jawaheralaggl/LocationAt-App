//
//  ViewController.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/18/20.
//

import UIKit
import SDWebImage
import CoreLocation

struct CustomData {
    var image: UIImage
}

class PlacesViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - properties
    
    // Uses CLLocationManager to ask the user for their location
    let locationManager = CLLocationManager()
    
    var places: [Places] = []
    var weather: [Weather] = []
    
    var mainSearchBar = SearchBar()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemBlue
        label.text = "What would you like to find?"
        return label
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .darkGray
        button.backgroundColor =  UIColor(white: 0, alpha: 0.1)
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoriesCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    let placesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PlacesCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    // dummy data for testing..
    let categoriesData = [
        CustomData(image: #imageLiteral(resourceName: "2")),
        CustomData(image: #imageLiteral(resourceName: "1")),
        CustomData(image: #imageLiteral(resourceName: "3")),
        CustomData(image: #imageLiteral(resourceName: "2")),
        CustomData(image: #imageLiteral(resourceName: "1")),
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        mainSearchBar.alpha = 0
        // Dismiss Keyboard when touch the view
        let tap = UITapGestureRecognizer(target: self.view ,action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        // Set delegates to this VC
        locationManager.delegate = self
        mainSearchBar.delegate = self
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        fetchPlacesAndWeatherAroundUser()
    }
    
    // MARK: - Helpers
    
    func fetchPlacesAndWeatherBySearch(lat: Double, long: Double) {
        
        fetchPlaces(latitude: lat, longitude: long, category: "coffee", limit: 25, sortBy: "distance") { (response, error) in
            
            if let response = response {
                self.places = response
                // Fetch weather data
                self.fetchWeather(latitude: lat, longitude: long) { (response, error) in
                    if let response = response {
                        self.weather = response
                        DispatchQueue.main.async {
                            self.placesCollectionView.reloadData()
                        }
                    }
                }
                
            }
        }
    }
    
    func fetchPlacesAndWeatherAroundUser() {
        
        let userLocation = getUserLocation(locationManager: locationManager)
        
        fetchPlaces(latitude: userLocation.lat, longitude: userLocation.long, category: "coffee", limit: 25, sortBy: "distance") { (response, error) in
            
            if let response = response {
                self.places = response
                // Fetch weather data
                self.fetchWeather(latitude: userLocation.lat, longitude: userLocation.long) { (response, error) in
                    if let response = response {
                        self.weather = response
                        DispatchQueue.main.async {
                            self.placesCollectionView.reloadData()
                        }
                    }
                }
                
            }
        }
    }
    
    // MARK: - Selectors
    
    @objc func searchButtonPressed() {
        showSearchBar()
    }
    
    // MARK: - layout
    
    func configureUI() {
        
        view.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(searchButton)
        searchButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        searchButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        searchButton.layer.cornerRadius = 30 / 2
        
        view.addSubview(mainSearchBar)
        mainSearchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5).isActive = true
        mainSearchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mainSearchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        mainSearchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.backgroundColor = .white
        categoriesCollectionView.topAnchor.constraint(equalTo: mainSearchBar.bottomAnchor).isActive = true
        categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        categoriesCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 3.5).isActive = true
        
        view.addSubview(placesCollectionView)
        placesCollectionView.backgroundColor = .white
        placesCollectionView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: -10).isActive = true
        placesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        placesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        placesCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    
}
