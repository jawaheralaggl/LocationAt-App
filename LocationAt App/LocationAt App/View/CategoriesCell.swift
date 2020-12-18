//
//  CategoriesCell.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/18/20.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    // MARK: - properties

    // Pass data for testing..
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            categoryImage.image = data.image
        }
    }
    
     let categoryImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    // MARK: - layout

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
        
        contentView.addSubview(categoryImage)
        categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        categoryImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        categoryImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        categoryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
