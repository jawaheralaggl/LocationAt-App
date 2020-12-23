//
//  FetchPlacesData.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/19/20.
//

import UIKit

class NetworkService {
    static let shared = NetworkService()
    
    // MARK: - Fetch data from Yelp API.
    
    // Set function to fetch data from Yelp Fusion API.
    func fetchPlaces(latitude: Double, longitude: Double, category: String, limit: Int, sortBy: String, completionHandler: @escaping ([Places]?, Error?) -> Void) {
        // Set array of places
        var placesList: [Places] = []
        
        // Create URL
        let queryItems = [URLQueryItem(name: "latitude", value: "\(latitude)"),
                          URLQueryItem(name: "longitude", value: "\(longitude)"),
                          URLQueryItem(name: "categories", value: category),
                          URLQueryItem(name: "limit", value: "\(limit)"),
                          URLQueryItem(name: "sort_by", value: sortBy)]
        
        var yelpURL = URLComponents(string: Constants.shared.yelpURL)!
        yelpURL.queryItems = queryItems
        
        let resultURL = yelpURL.url!
        
        // Create request
        var request = URLRequest(url: resultURL)
        request.setValue("Bearer \(Constants.shared.yelpApiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        // Initialize session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { completionHandler(nil, error) }
            do{
                // Read data as JSON
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                // Main dictionary
                guard let response = json as? NSDictionary else { return }
                
                // Businesses(Places)
                guard let businesses = response.value(forKey: "businesses") as? [NSDictionary] else { return }
                
                print("\(businesses)")
                
                // Accessing each business(places)
                for business in businesses {
                    var place = Places()
                    place.name = business.value(forKey: "name") as? String
                    place.id = business.value(forKey: "id") as? String
                    place.image_url = business.value(forKey: "image_url") as? String
                    place.rating = business.value(forKey: "rating") as? Float
                    place.is_closed = business.value(forKey: "is_closed") as? Bool
                    place.distance = business.value(forKey: "distance") as? Double
                    
                    let address = business.value(forKeyPath: "location.display_address") as? [String]
                    place.address = address?.joined(separator: "\n")
                    
                    placesList.append(place)
                }
                
                completionHandler(placesList, nil)
            }catch{
                print("error found")
                completionHandler(nil, error)
            }
        }.resume()
        
    }
    
    // MARK: - Fetch data from WeatherAPI.
    
    func fetchWeather(latitude: Double, longitude: Double, completionHandler: @escaping ([Weather]?, Error?) -> Void) {
        // Set array of weather
        var weatherList: [Weather] = []
        
        // Create URL
        let queryItems = [URLQueryItem(name: "key", value: Constants.shared.weatherApiKey),
                          URLQueryItem(name: "q", value: "\(latitude),\(longitude)")]
        
        var weatherURL = URLComponents(string: Constants.shared.weatherURL)!
        weatherURL.queryItems = queryItems
        
        let resultURL = weatherURL.url!
        
        // Creating request
        var request = URLRequest(url: resultURL)
        request.httpMethod = "GET"
        
        // Initialize session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { completionHandler(nil, error) }
            do {
                // Read data as JSON
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                // Main dictionary
                guard let response = json as? NSDictionary else { return }
                print(response)
                
                // Weather dictionaries
                guard let currentWeather = response["current"] as? NSDictionary else { return }
                guard let weatherCondition = currentWeather["condition"] as? NSDictionary else { return }
                
                print("\(currentWeather)")
                
                // Accessing weather of each places
                for _ in currentWeather {
                    var weather = Weather()
                    weather.temp_f = currentWeather["temp_f"] as? Double
                    weather.text = weatherCondition["text"] as? String
                    weather.icon = weatherCondition["icon"] as? String
                    
                    weatherList.append(weather)
                }
                completionHandler(weatherList, nil)
            }catch{
                print("error found")
                completionHandler(nil, error)
            }
        }.resume()
        
    }
    
}
