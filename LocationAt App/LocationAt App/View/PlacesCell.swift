//
//  PlacesCell.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/18/20.
//

import UIKit

class PlacesCell: UICollectionViewCell {
    
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
        label.text = "name"
        label.textColor = .black
        return label
    }()
    
    let isClosedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .gray
        
        contentView.addSubview(placeImage)
        placeImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        placeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        placeImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        placeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        placeImage.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: placeImage.leadingAnchor, constant: 8).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: -16).isActive = true
        
        placeImage.addSubview(isClosedLabel)
        isClosedLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        isClosedLabel.bottomAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: -16).isActive = true
        isClosedLabel.trailingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
