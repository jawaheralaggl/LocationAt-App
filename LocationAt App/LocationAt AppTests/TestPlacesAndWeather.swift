//
//  TestPlacesAndWeather.swift
//  LocationAt AppTests
//
//  Created by Jawaher Alagel on 12/28/20.
//

@testable import LocationAt_App
import XCTest

class TestPlacesAndWeather: XCTestCase {
    
    let placesService = PlacesViewController()
    let serviceConstants = Constants()
    
    func testNetworkServiceConstants() {
        // if equals, url is correct
        XCTAssertEqual(TestConstants.yelpURL, serviceConstants.yelpURL)
        XCTAssertEqual(TestConstants.weatherURL, serviceConstants.weatherURL)
        
        // apiKey + string URL must not be nil, otherwise the test fails
        XCTAssertNotNil(serviceConstants.yelpApiKey)
        XCTAssertNotNil(serviceConstants.weatherApiKey)
        XCTAssertNotNil(serviceConstants.yelpURL)
        XCTAssertNotNil(serviceConstants.weatherURL)
    }
    
    func testPlacesAndWeather() {
        // arrays must not be nil, otherwise the test fails
        XCTAssertNotNil(placesService.places)
        XCTAssertNotNil(placesService.weather)
    }
    
    func testFetchPlacesAndWeatherAroundUser() {
        XCTAssertNotNil(placesService.fetchPlacesAndWeatherAroundUser())
    }
    
    func testValidSortBy() {
        let sortBy = SortByValidator()
        let result = sortBy.isValid("distance")
        XCTAssertTrue(result)
    }
    
    func testValidLimit() {
        let limit = LimitValidator()
        let result = limit.isValid(20)
        XCTAssertTrue(result)
        
        XCTAssertGreaterThan(TestConstants.limit, 15)
    }
    
}
