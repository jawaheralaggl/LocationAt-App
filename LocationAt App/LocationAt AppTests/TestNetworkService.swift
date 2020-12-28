//
//  TestNetworkService.swift
//  LocationAt AppTests
//
//  Created by Jawaher Alagel on 12/28/20.
//

@testable import LocationAt_App
import XCTest

class TestNetworkService: XCTestCase {
    
    let networkService = NetworkService()
    let placesService = PlacesViewController()
    
    func testFetchPlaces() {
        // 1. Define an expectation
        let expectation = self.expectation(description: "Fetch places successfully")
        
        // 2. The asynchronous code
        let userLocation = placesService.getUserLocation(locationManager: placesService.locationManager)
        
        networkService.fetchPlaces(latitude: userLocation.lat, longitude: userLocation.lat, category: TestConstants.categories, limit: TestConstants.limit, sortBy: TestConstants.sortBy) { success, failure  in
            XCTAssertTrue((success != nil))
            
            if failure != nil { // Handle failure
                XCTFail("Fail")
            }
            
            // Fulfill the expectation in the async callback
            expectation.fulfill()
        }
        
        // 3. Wait for the expectation to be fulfilled
        self.waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Found errored: \(error)")
            }
        }
    }
    
    func testFetchWeather() {
        // 1. Define an expectation
        let expectation = self.expectation(description: "Fetch weather successfully")
        
        // 2. The asynchronous code
        let userLocation = placesService.getUserLocation(locationManager: placesService.locationManager)
        
        networkService.fetchWeather(latitude: userLocation.lat, longitude: userLocation.lat, completionHandler: { success, failure  in
            XCTAssertTrue((success != nil))
            
            if failure != nil { // Handle failure
                XCTFail("Fail")
            }
            
            // Fulfill the expectation in the async callback
            expectation.fulfill()
        })
        
        // 3. Wait for the expectation to be fulfilled
        self.waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Found errored: \(error)")
            }
        }
    }
    
    
}
