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
        // Define an expectation
        let expectation = self.expectation(description: "Fetch places successfully")
        
        // The asynchronous code
        let userLocation = placesService.getUserLocation(locationManager: placesService.locationManager)
        
        networkService.fetchPlaces(latitude: userLocation.lat, longitude: userLocation.long, category: TestConstants.categories, limit: TestConstants.limit, sortBy: TestConstants.sortBy) { result, error in
            XCTAssertTrue((result != nil))
            XCTAssertNotNil(result, "result is nil")
            
            if error != nil { // Handle error
                XCTFail("Failed to fetch places from the server")
            }
            
            // Fulfill the expectation in the async callback
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        self.waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Found errored: \(error)")
            }
        }
    }
    
    func testFetchWeather() {
        // Define an expectation
        let expectation = self.expectation(description: "Fetch weather successfully")
        
        // The asynchronous code
        let userLocation = placesService.getUserLocation(locationManager: placesService.locationManager)
        
        networkService.fetchWeather(latitude: userLocation.lat, longitude: userLocation.long, completionHandler: { result, error in
            XCTAssertTrue((result != nil))
            XCTAssertNotNil(result, "result is nil")
            
            if error != nil { // Handle error
                XCTFail("Failed to fetch weather from the server")
            }
            
            // Fulfill the expectation in the async callback
            expectation.fulfill()
        })
        
        // Wait for the expectation to be fulfilled
        self.waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Found errored: \(error)")
            }
        }
    }
    
    
}
