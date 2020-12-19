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
        label.textColor = .white
        return label
    }()
    
    let isClosedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
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
    
    // MARK: - layout
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 25
        
        contentView.addSubview(placeImage)
        placeImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        placeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        placeImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        placeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        placeImage.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: placeImage.leadingAnchor, constant: 8).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: -16).isActive = true
        
        placeImage.addSubview(isClosedLabel)
        isClosedLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        isClosedLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
        isClosedLabel.bottomAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: -16).isActive = true
        isClosedLabel.trailingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
