//
//  ViewController.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/18/20.
//

import UIKit

struct CustomData {
    var image: UIImage
}

class PlacesViewController: UIViewController {
    
    // MARK: - properties
    
    var mainSearchBar = SearchBar()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemBlue
        label.text = "What would you like to find?"
        return label
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .darkGray
        button.backgroundColor =  UIColor(white: 0, alpha: 0.1)
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
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
    
    // dummy data for testing..
    fileprivate let categoriesData = [
        CustomData(image: #imageLiteral(resourceName: "2")),
        CustomData(image: #imageLiteral(resourceName: "1")),
        CustomData(image: #imageLiteral(resourceName: "3")),
        CustomData(image: #imageLiteral(resourceName: "2")),
        CustomData(image: #imageLiteral(resourceName: "1")),
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        // Set searchbar delegate to this VC
        mainSearchBar.delegate = self
        mainSearchBar.alpha = 0
        
        // Set collectionviews delegate and dataSource to this VC
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
    // MARK: - Selectors
    
    @objc func searchButtonPressed() {
        showSearchBar()
    }
    
    // MARK: - layout
    
    func configureUI() {
        
        view.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(searchButton)
        searchButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        searchButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        searchButton.layer.cornerRadius = 30 / 2
        
        view.addSubview(mainSearchBar)
        mainSearchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5).isActive = true
        mainSearchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mainSearchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        mainSearchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.backgroundColor = .white
        categoriesCollectionView.topAnchor.constraint(equalTo: mainSearchBar.bottomAnchor).isActive = true
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

// MARK: - UICollectionViewDelegateFlowLayout

extension PlacesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set different size for each collectionview
        if collectionView == self.placesCollectionView {
            return CGSize(width: collectionView.frame.width/1.5, height: collectionView.frame.width/1)
        }else{
            return CGSize(width: collectionView.frame.width/5.5, height: collectionView.frame.width/5.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Set different spacing for each collectionview
        if collectionView == self.placesCollectionView {
            return 30
        }else{
            return 20
        }
    }
}
// MARK: - UICollectionViewDataSource

extension PlacesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return different numberOfItems for each collectionview
        if collectionView == self.placesCollectionView {
            return 10
        }else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Set different cell for each collectionview
        if collectionView == self.placesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlacesCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoriesCell
            // display data
            cell.data = self.categoriesData[indexPath.item]
            return cell
        }
    }
    
}

// MARK: - UISearchBarDelegate

extension PlacesViewController: UISearchBarDelegate {

    func showSearchBar() {
        UIView.animate(withDuration: 0.5, animations: {
            self.searchButton.alpha = 0
            self.mainSearchBar.alpha = 1
            self.searchBarCancelIcon()
        }, completion: { finished in
            self.mainSearchBar.becomeFirstResponder()
        })
    }
    
    func hideSearchBar() {
        searchButton.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.mainSearchBar.alpha = 0
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
    
    func searchBarCancelIcon() {
        mainSearchBar.setValue(" ", forKey: "cancelButtonText")
        mainSearchBar.showsCancelButton = true
        let cancelButton = self.mainSearchBar.value(forKey: "cancelButton") as? UIButton
        cancelButton?.tintColor = UIColor(white: 0, alpha: 0.1)
        cancelButton?.setImage(UIImage(named: "cancel"), for: .normal)
    }
    
}
