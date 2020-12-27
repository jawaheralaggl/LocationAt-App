//
//  Constants.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/22/20.
//

import UIKit

class Constants {
    static let shared = Constants()
    
    let yelpApiKey = "UUKIQnweDQKTPWj0Ud4q87f3eEg33Nm3gAWWFy9LDefkq2Q5VjQLgL5BYtmIZBgHJiAy0ZEmjDj_bRlh4ZD7NoxdFAKgUA8mRwCL7jMy6JNWgCXLYdXnI8bJrAHdX3Yx"
    
    let weatherApiKey = "4864c9327f224f1c863212329202112"
    
    let yelpURL = "https://api.yelp.com/v3/businesses/search"
    
    let weatherURL = "https://api.weatherapi.com/v1/current.json"
    
    let sanFranciscoCoords = (Double(37.773972), Double(-122.431297))
    
    let mainFont = "Avenir-Black"
    
    let mainColor = UIColor(named: "Deep Sapphire")
    let buttonsColor = UIColor(named: "buttons Color")
    let viewsColor = UIColor(named: "Views Color")
    let clearColor = UIColor(white: 0.3, alpha: 0.3)
}
