//
//  DetailsViewController.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/21/20.
//

import UIKit
import SDWebImage
import QuartzCore
import RealmSwift

class DetailsViewController: UIViewController {
    
    // MARK: - properties
    
    // Create instance of Realm
    let realm = try! Realm()
    
    var passedPlacesNames: String!
    var passedIsClosed: Bool!
    var passedWeatherTemps: String!
    var passedWeatherText: String!
    var passedPlacesImages: URL!
    var passedWeatherImages: URL!
    var passedAdress: String!
    var passedRating: String!
    var passedDistance: String!
    
    // Change the properties accordingly
    var isClosed: Bool = false {
        didSet {
            if isClosed {
                isClosedLabel.text = "Closed"
                isClosedLabel.backgroundColor = .red
            } else {
                isClosedLabel.text = "Open"
                isClosedLabel.backgroundColor = .systemGreen
            }
        }
    }
    
    let disView: UIView = {
        let view = UIView(frame: CGRect(x: 8, y: 6, width: 190, height: 80))
        view.backgroundColor = Constants.shared.viewsColor
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let weatherView: UIView = {
        let view = UIView(frame: CGRect(x: 212, y: 6, width: 190, height: 80))
        view.backgroundColor = Constants.shared.viewsColor
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let disTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.shared.mainFont, size: 15)
        label.textColor = Constants.shared.mainColor
        label.text = "Distance"
        label.textAlignment = .left
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.shared.mainFont, size: 25)
        label.textColor = Constants.shared.mainColor
        label.textAlignment = .left
        return label
    }()
    
    let weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let weatherTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.shared.mainFont, size: 25)
        label.textColor = Constants.shared.mainColor
        return label
    }()
    
    let weatherText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.shared.mainFont, size: 19)
        label.textColor = Constants.shared.mainColor
        return label
    }()
    
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
        label.font = UIFont(name: Constants.shared.mainFont, size: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.backgroundColor = Constants.shared.clearColor
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    let isClosedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.shared.mainFont, size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    let destinationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Destination", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: Constants.shared.mainFont, size: 25)
        button.backgroundColor = Constants.shared.mainColor
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleDestinationTapped), for: .touchUpInside)
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "share"), for: .normal)
        button.backgroundColor = Constants.shared.viewsColor
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = Constants.shared.clearColor
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        
        nameLabel.text = passedPlacesNames
        ratingLabel.text = "★ " + passedRating
        isClosed = passedIsClosed
        
        weatherTemp.text = passedWeatherTemps
        weatherText.text = passedWeatherText
        distanceLabel.text = passedDistance
        
        placeImage.sd_setImage(with: passedPlacesImages, completed: nil)
        weatherImage.sd_setImage(with: passedWeatherImages, completed: nil)
        
        saveRecents()
    }
    
    func configureUI(){
        
        view.addSubview(weatherView)
        
        weatherView.addSubview(weatherImage)
        weatherImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        weatherImage.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 10).isActive = true
        weatherImage.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor).isActive = true
        
        weatherView.addSubview(weatherTemp)
        weatherTemp.widthAnchor.constraint(equalToConstant: 120).isActive = true
        weatherTemp.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 8).isActive = true
        weatherTemp.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 8).isActive = true
        weatherTemp.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -8).isActive = true
        
        weatherView.addSubview(weatherText)
        weatherText.widthAnchor.constraint(equalToConstant: 120).isActive = true
        weatherText.topAnchor.constraint(equalTo: weatherTemp.bottomAnchor, constant: 5).isActive = true
        weatherText.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -8).isActive = true
        
        view.addSubview(disView)
        
        disView.addSubview(disTitleLabel)
        disTitleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        disTitleLabel.topAnchor.constraint(equalTo: disView.topAnchor, constant: 8).isActive = true
        disTitleLabel.leadingAnchor.constraint(equalTo: disView.leadingAnchor, constant: 8).isActive = true
        disTitleLabel.trailingAnchor.constraint(equalTo: disView.trailingAnchor, constant: -8).isActive = true
        
        disView.addSubview(distanceLabel)
        distanceLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        distanceLabel.topAnchor.constraint(equalTo: disTitleLabel.bottomAnchor, constant: 8).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: disView.leadingAnchor, constant: 8).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: disView.trailingAnchor, constant: -8).isActive = true
        
        view.addSubview(placeImage)
        placeImage.heightAnchor.constraint(equalToConstant: 640).isActive = true
        placeImage.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 10).isActive = true
        placeImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        placeImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        placeImage.addSubview(nameLabel)
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: placeImage.leadingAnchor, constant: 8).isActive = true
        
        placeImage.addSubview(isClosedLabel)
        isClosedLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        isClosedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        isClosedLabel.leadingAnchor.constraint(equalTo: placeImage.leadingAnchor, constant: 8).isActive = true
        isClosedLabel.bottomAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: -16).isActive = true
        isClosedLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(destinationButton)
        destinationButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        destinationButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        destinationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        destinationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(shareButton)
        shareButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: destinationButton.leadingAnchor, constant: -20).isActive = true
        
        placeImage.addSubview(ratingLabel)
        ratingLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: -16).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: -8).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: - Helpers
    
    // Save recents data to Realm
    func saveRecents() {
        let recents = Recents()
        recents.name = passedPlacesNames
        recents.address = passedAdress
        print("DEBUG: name of place: \(recents.name)")
        print("DEBUG: address of place: \(recents.address)")
        
        realm.beginWrite()
        realm.add(recents)
        try! realm.commitWrite()
    }
    
    func passData(for placeName: String, isClosed: Bool ,placeImage: URL, weatherImages: URL, weatherTemp: String, weatherText: String, address: String, rating: String, distance: String) {
        self.passedPlacesNames = placeName
        self.passedPlacesImages = placeImage
        self.passedIsClosed = isClosed
        self.passedRating = rating
        
        self.passedWeatherImages = weatherImages
        self.passedWeatherTemps = weatherTemp
        self.passedWeatherText = weatherText
        self.passedDistance = distance
        
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
