//
//  TestConstants.swift
//  LocationAt AppTests
//
//  Created by Jawaher Alagel on 12/28/20.
//

import UIKit

enum TestConstants {
    
    static let yelpApiKey = "UUKIQnweDQKTPWj0Ud4q87f3eEg33Nm3gAWWFy9LDefkq2Q5VjQLgL5BYtmIZBgHJiAy0ZEmjDj_bRlh4ZD7NoxdFAKgUA8mRwCL7jMy6JNWgCXLYdXnI8bJrAHdX3Yx"
    
    static let weatherApiKey = "4864c9327f224f1c863212329202112"
    
    static let yelpURL = "https://api.yelp.com/v3/businesses/search"
    
    static let weatherURL = "https://api.weatherapi.com/v1/current.json"
    
    static let categories = ""
    
    static let sortBy = "distance"
    
    static let limit = 20
}

// MARK: - Test Structs

struct SortByValidator { // Check the type of sorting
    func isValid(_ sortBy: String) -> Bool {
        return sortBy == "distance"
    }
}

struct LimitValidator { // Check the limit of business results to return
    func isValid(_ limit: Int) -> Bool {
        return limit == 20
    }
}
