//
//  PlacesViewController + Searching.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/20/20.
//

import UIKit

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
