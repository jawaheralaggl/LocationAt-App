//
//  DetailsViewController.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/21/20.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - properties
    
    let placeImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "2")
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Starbucks"
        label.textColor = .black
        return label
    }()
    
    let isClosedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Open"
        label.textColor = .black
        return label
    }()
    
    let weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "3")
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "62F"
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .gray
    }
    
    func configureUI(){
        view.addSubview(placeImage)
        placeImage.heightAnchor.constraint(equalToConstant: 450).isActive = true
        placeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        placeImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        placeImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        placeImage.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: placeImage.topAnchor, constant: 390).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: placeImage.leadingAnchor, constant: 8).isActive = true
        
        placeImage.addSubview(isClosedLabel)
        isClosedLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        isClosedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        isClosedLabel.leadingAnchor.constraint(equalTo: placeImage.leadingAnchor, constant: 8).isActive = true
        isClosedLabel.bottomAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: -16).isActive = true
        
        view.addSubview(weatherImage)
        weatherImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        weatherImage.topAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: 100).isActive = true
        weatherImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        
        view.addSubview(weatherLabel)
        weatherLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        weatherLabel.topAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: 130).isActive = true
        weatherLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 20).isActive = true
    }
    
}
