//
//  PlacesViewController + Searching.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/20/20.
//

import UIKit
import CoreLocation

// MARK: - UISearchBarDelegate

extension PlacesViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let address = searchBar.text!
        
        // Get geographic coordinates for places name
        getPlaceCoordinate(address: address) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            
            self.fetchPlacesAndWeatherBySearch(lat: coordinate.latitude, long: coordinate.longitude)
            DispatchQueue.main.async {
                print(address, "coordinate:", coordinate)
                self.placesCollectionView.reloadData()
            }
        }
        
    }
    
    func showSearchBar() {
        mainSearchBar.placeholder = "Search by address"
        UIView.animate(withDuration: 1, animations: {
            self.searchButton.alpha = 0
            self.mainSearchBar.alpha = 1
            self.searchBarCancelIcon()
        }, completion: { finished in
            self.mainSearchBar.becomeFirstResponder()
            self.mainSearchBar.placeholder = "Wall Street. New York City"
        })
    }
    
    func hideSearchBar() {
        searchButton.alpha = 1
        self.mainSearchBar.text = ""
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
    
    // Method to begin the search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // Scroll back to the first index after the search
        placesCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }
    
}
