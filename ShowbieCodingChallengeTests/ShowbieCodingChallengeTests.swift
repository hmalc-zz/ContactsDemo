//
//  ShowbieCodingChallengeTests.swift
//  ShowbieCodingChallengeTests
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import XCTest
@testable import ShowbieCodingChallenge

class ShowbieCodingChallengeTests: XCTestCase {
    
    var apiResponse: RandomUserAPIResponse?
    var testUser: RandomUser?
    
    override func setUp() {
        super.setUp()
        
        if let path = Bundle.main.path(forResource: "Example", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = RandomUserAPIService.API_TIME_FORMAT
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let result = try decoder.decode(RandomUserAPIResponse.self, from: data)
                apiResponse = result
                testUser = result.results.first
            } catch let error {
               XCTAssert(false, error.localizedDescription)
            }
        } else {
            XCTAssert(false, "Can't find local file")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test50UsersInstantiated() {
        guard let response = apiResponse else {
            XCTAssert(false, "Could not initiate api response")
            return
        }
        XCTAssert(response.results.count == 50)
    }
    
    func testNameFormatting(){
        guard let testUserToReview = testUser else {
            XCTAssert(false, "Could not initiate test user")
            return
        }
        XCTAssert(testUserToReview.name.formattedName == "Mr Olivier Park")
    }
    
    func testFormattedLocaleInfo() {
        guard let testUserToReview = testUser else {
            XCTAssert(false, "Could not initiate test user")
            return
        }
        print(testUserToReview.location.formattedLocaleInfo)
        XCTAssert(testUserToReview.location.formattedLocaleInfo == "Jasper, Nova Scotia Y4M 1I5")
    }
    
    func testBirthDayFormatting(){
        guard let testUserToReview = testUser else {
            XCTAssert(false, "Could not initiate test user")
            return
        }
        print(testUserToReview.location.formattedLocaleInfo)
        XCTAssert(testUserToReview.dob.formattedDate == "February 1, 1979")
    }
    
}
