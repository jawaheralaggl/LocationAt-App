//
//  SearchBar.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/18/20.
//

import UIKit

class SearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
