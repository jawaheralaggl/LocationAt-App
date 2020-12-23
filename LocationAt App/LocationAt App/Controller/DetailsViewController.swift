//
//  DetailsViewController.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/21/20.
//

import UIKit
import SDWebImage
import QuartzCore

class DetailsViewController: UIViewController {
    
    // MARK: - properties
    
    var passedPlacesNames: String!
    var passedIsClosed: Bool!
    var passedWeatherTemps: String!
    var passedWeatherText: String!
    var passedPlacesImages: URL!
    var passedWeatherImages: URL!
    var passedAdress: String!
    
    // Change the properties accordingly
    var isClosed: Bool = false {
        didSet {
            if isClosed {
                isClosedLabel.text = "Closed"
                isClosedLabel.textColor = .white
                isClosedLabel.backgroundColor = .red
            } else {
                isClosedLabel.text = "Open"
                isClosedLabel.textColor = .white
                isClosedLabel.backgroundColor = .systemGreen
            }
        }
    }
    
    let placeImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    let isClosedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    let weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let weatherTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    let weatherText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let destinationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Destination", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleDestinationTapped), for: .touchUpInside)
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        
        nameLabel.text = passedPlacesNames
        isClosed = passedIsClosed
        
        weatherTemp.text = passedWeatherTemps
        weatherText.text = passedWeatherText
        
        placeImage.sd_setImage(with: passedPlacesImages, completed: nil)
        weatherImage.sd_setImage(with: passedWeatherImages, completed: nil)
    }
    
    func configureUI(){
        view.addSubview(placeImage)
        placeImage.heightAnchor.constraint(equalToConstant: 500).isActive = true
        placeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        placeImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        placeImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        placeImage.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: placeImage.leadingAnchor, constant: 8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        placeImage.addSubview(isClosedLabel)
        isClosedLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        isClosedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        isClosedLabel.leadingAnchor.constraint(equalTo: placeImage.leadingAnchor, constant: 8).isActive = true
        isClosedLabel.bottomAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: -16).isActive = true
        isClosedLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(weatherImage)
        weatherImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        weatherImage.topAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: 50).isActive = true
        weatherImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        
        view.addSubview(weatherTemp)
        weatherTemp.widthAnchor.constraint(equalToConstant: 120).isActive = true
        weatherTemp.topAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: 65).isActive = true
        weatherTemp.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 8).isActive = true
        weatherTemp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        
        view.addSubview(weatherText)
        weatherText.widthAnchor.constraint(equalToConstant: 120).isActive = true
        weatherText.topAnchor.constraint(equalTo: weatherTemp.bottomAnchor, constant: 10).isActive = true
        weatherText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170).isActive = true
        weatherText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        
        view.addSubview(destinationButton)
        destinationButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        destinationButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        destinationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        destinationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(shareButton)
        shareButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: destinationButton.leadingAnchor, constant: -20).isActive = true
    }
    
    // MARK: - Helpers
    
    func passData(for placeName: String, isClosed: Bool ,placeImage: URL, weatherImages: URL, weatherTemp: String, weatherText: String, address: String) {
        self.passedPlacesNames = placeName
        self.passedPlacesImages = placeImage
        self.passedIsClosed = isClosed
        self.passedWeatherImages = weatherImages
        self.passedWeatherTemps = weatherTemp
        self.passedWeatherText = weatherText
        
        self.passedAdress = address
    }
    
    // MARK: - Selectors
    
    @objc func handleShareTapped() {
        // Data to share
        let names = passedPlacesNames!
        let weather = passedWeatherText!
        let images = passedPlacesImages!
        
        // Set up activity view controller
        let activityViewController = UIActivityViewController(activityItems: [names, "is: \(weather)", images], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func handleDestinationTapped() {
        let address = passedAdress!
        
        let userLocation = PlacesViewController.shared.getUserLocation(locationManager: PlacesViewController.shared.locationManager)
        
        PlacesViewController.shared.getPlaceCoordinate(address: address) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            
            // Check if user has the app in his device
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                if let url = URL(string: "comgooglemaps-x-callback://?saddr=\(userLocation.lat),\(userLocation.long)&daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving") {
                    UIApplication.shared.open(url, options: [:])
                }
            }else{
                // If not, open in browser
                if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=\(userLocation.lat),\(userLocation.long)&daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving") {
                    UIApplication.shared.open(urlDestination)
                }
            }
            
        }
    }
    
}
