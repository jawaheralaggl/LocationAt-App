//
//  ViewController.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/18/20.
//

import UIKit

class PlacesViewController: UIViewController {
    
    // MARK: - properties
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoriesCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let placesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PlacesCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
   
    }
    
    // MARK: - layout
    
    func configureUI() {
        
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.backgroundColor = .white
        categoriesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
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
