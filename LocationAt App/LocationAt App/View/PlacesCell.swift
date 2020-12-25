//
//  PlacesCell.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/18/20.
//

import UIKit

class PlacesCell: UICollectionViewCell {
    
    // MARK: - properties
    
    let placeImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.shared.mainFont, size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()
    
    let isClosedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.shared.mainFont, size: 15)
        label.textColor = .black
        return label
    }()
    
    let weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // Set isClosed variable to true or false and the properties will be set accordingly
    var isClosed: Bool = false {
        didSet {
            if isClosed {
                isClosedLabel.text = "Closed"
                isClosedLabel.textColor = .red
            } else {
                isClosedLabel.text = "Open"
                isClosedLabel.textColor = .systemGreen
            }
        }
    }
    
    func configure(name: String, isClosed: Bool) {
        self.nameLabel.text = name
        self.isClosed = isClosed
    }
    
    // MARK: - layout
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 25
        // Set shadow to the cell
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.23
        contentView.layer.shadowRadius = 4
        
        contentView.addSubview(placeImage)
        placeImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        placeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        placeImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        placeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60).isActive = true
        
        contentView.addSubview(nameLabel)
        nameLabel.widthAnchor.constraint(equalToConstant: 190).isActive = true
        nameLabel.topAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        
        contentView.addSubview(isClosedLabel)
        isClosedLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        isClosedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        isClosedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        isClosedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        isClosedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        contentView.addSubview(weatherImage)
        weatherImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        weatherImage.topAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: 8).isActive = true
        weatherImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        weatherImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
