//
//  ViewController.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/18/20.
//

import UIKit
import SDWebImage
import CoreLocation

class PlacesViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    static let shared = PlacesViewController()
    
    // Uses CLLocationManager to ask the user for their location
    let locationManager = CLLocationManager()
    
    var places: [Places] = []
    var weather: [Weather] = []
    var categories: String = ""
    
    var mainSearchBar = SearchBar() 
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.shared.mainFont, size: 40)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = Constants.shared.mainColor
        label.text = "What would you like to find?"
        return label
    }()
    
    let recentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .darkGray
        button.backgroundColor =  Constants.shared.buttonsColor
        button.setImage(UIImage(named: "recent"), for: .normal)
        button.addTarget(self, action: #selector(recentsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .darkGray
        button.backgroundColor =  Constants.shared.buttonsColor
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let segmentedControl: SegmentedControl = {
        let segmentedCtrl = SegmentedControl()
        segmentedCtrl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedCtrl
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        cunfigureSegmentedCtrl()
        
        // Dismiss Keyboard when touch the view
        let tap = UITapGestureRecognizer(target: self.view ,action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        // Set delegates to this VC
        locationManager.delegate = self
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self
        mainSearchBar.delegate = self
        
        mainSearchBar.alpha = 0
        
        fetchPlacesAndWeatherAroundUser()
    }
    
    // MARK: - Helpers
    
    func fetchPlacesAndWeatherBySearch(lat: Double, long: Double) {
        
        NetworkService.shared.fetchPlaces(latitude: lat, longitude: long, category: categories, limit: 20, sortBy: "distance") { (response, error) in
            
            if let response = response {
                self.places = response
                // Fetch weather data
                NetworkService.shared.fetchWeather(latitude: lat, longitude: long) { (response, error) in
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
        
        NetworkService.shared.fetchPlaces(latitude: userLocation.lat, longitude: userLocation.long, category: categories, limit: 20, sortBy: "distance") { (response, error) in
            
            if let response = response {
                self.places = response
                // Fetch weather data
                NetworkService.shared.fetchWeather(latitude: userLocation.lat, longitude: userLocation.long) { (response, error) in
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
    
    @objc func recentsButtonPressed() {
        let controller = RecentsViewController()
        present(controller, animated: true)
    }
    
    @objc func searchButtonPressed() {
        showSearchBar()
    }
    
    @objc func segmentValueChanged(){
        switch segmentedControl.selectedIndex {
        case 0:
            categories = "restaurants"
        case 1:
            categories = "coffee"
        case 2:
            categories = "amusementparks"
        case 3:
            categories = "hotels"
        default:
            break
        }
        fetchPlacesAndWeatherAroundUser()
    }
    
    
    // MARK: - Layout
    
    func cunfigureSegmentedCtrl() {
        segmentedControl.items = ["Restaurants", "Coffee", "Parks", "Hotels"]
        segmentedControl.selectedIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    func configureUI() {
        view.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(recentsButton)
        recentsButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        recentsButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        recentsButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        recentsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        recentsButton.layer.cornerRadius = 10
        
        view.addSubview(searchButton)
        searchButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        searchButton.leftAnchor.constraint(equalTo: recentsButton.rightAnchor, constant: 8).isActive = true
        searchButton.layer.cornerRadius = 10
        
        view.addSubview(mainSearchBar)
        mainSearchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5).isActive = true
        mainSearchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mainSearchBar.leftAnchor.constraint(equalTo: recentsButton.rightAnchor, constant: 5).isActive = true
        mainSearchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: mainSearchBar.bottomAnchor, constant: 8).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(placesCollectionView)
        placesCollectionView.backgroundColor = .white
        placesCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8).isActive = true
        placesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        placesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        placesCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 0.8).isActive = true
    }
    
}
