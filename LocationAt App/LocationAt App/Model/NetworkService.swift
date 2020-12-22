//
//  FetchPlacesData.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/19/20.
//

import UIKit

class NetworkService {
    static let shared = NetworkService()
    
    // Set function to fetch data from Yelp Fusion API.
    func fetchPlaces(latitude: Double, longitude: Double, category: String, limit: Int, sortBy: String, completionHandler: @escaping ([Places]?, Error?) -> Void) {
        // Set array of places
        var placesList: [Places] = []
        
        let apikey = "UUKIQnweDQKTPWj0Ud4q87f3eEg33Nm3gAWWFy9LDefkq2Q5VjQLgL5BYtmIZBgHJiAy0ZEmjDj_bRlh4ZD7NoxdFAKgUA8mRwCL7jMy6JNWgCXLYdXnI8bJrAHdX3Yx"
        
        // Create URL
        let baseURL = "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=\(category)&limit=\(limit)&sort_by=\(sortBy)"
        
        let url = URL(string: baseURL)
        
        // Create request
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
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
        
        let apikey = "4864c9327f224f1c863212329202112"
        
        // Create URL
        let weatherURL = "https://api.weatherapi.com/v1/current.json?key=\(apikey)&q=\(latitude),\(longitude)"
        let url = URL(string: weatherURL)
        
        // Creating request
        var request = URLRequest(url: url!)
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
