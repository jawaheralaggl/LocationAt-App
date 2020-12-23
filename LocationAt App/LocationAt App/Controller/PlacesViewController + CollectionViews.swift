//
//  PlacesViewController + CollectionViews.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/20/20.
//

import UIKit

// MARK: - UICollectionViewDelegateFlowLayout

extension PlacesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set different size for each collectionview
        if collectionView == self.placesCollectionView {
            return CGSize(width: collectionView.frame.width/1.5, height: collectionView.frame.width/0.8)
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
            return places.count
        }else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Set different cell for each collectionview
        if collectionView == self.placesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlacesCell
            // Filling the cell content and set default value in case nil values occur
            cell.configure(name: places[indexPath.row].name ?? "", isClosed: places[indexPath.row].is_closed ?? false)
            
            // Convert string to URL then set the imageView with an url
            guard let placeImageUrl = URL(string: places[indexPath.row].image_url ?? "") else { return cell }
            cell.placeImage.sd_setImage(with: placeImageUrl, completed: nil)
            guard let weatherImageUrl = URL(string: "https:\(weather[indexPath.row].icon ?? "")") else { return cell }
            cell.weatherImage.sd_setImage(with: weatherImageUrl, completed: nil)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoriesCell
            // display data
            cell.data = self.categoriesData[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.placesCollectionView {
            let controller = DetailsViewController()
            
            // convert strint to URL
            guard let placeImageUrl = URL(string: places[indexPath.row].image_url ?? "") else { return }
            guard let weatherImageUrl = URL(string: "https:\(weather[indexPath.row].icon ?? "")") else { return }
            
            // pass selected cell data to next view
            controller.passData(for: places[indexPath.row].name ?? "",
                                isClosed: places[indexPath.row].is_closed ?? false,
                                placeImage: placeImageUrl,
                                weatherImages: weatherImageUrl,
                                weatherTemp: "\(weather[indexPath.row].temp_f ?? 0.0) °F",
                                weatherText: weather[indexPath.row].text ?? "",
                                address: places[indexPath.row].address ?? "",
                                rating: "\(places[indexPath.row].rating ?? 0.0)")
            present(controller, animated: true)
        }
    }
    
}
