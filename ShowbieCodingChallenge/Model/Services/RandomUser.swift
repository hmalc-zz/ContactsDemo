//
//  RandomUser.swift
//  ShowbieCodingChallenge
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import Foundation

/// API as mapped from documentation reference: https://randomuser.me/documentation

struct RandomUserAPIResponse: Codable {
    
    let results: [RandomUser]
    let info: RandomUserAPIMetadata
    struct RandomUserAPIMetadata: Codable {
        let seed: String
        let results: Int
        let page: Int
        let version: String
    }
}

struct RandomUser: Codable {
    let gender: String
    let name: RandomUserName
    let location: RandomUserLocation
    let email: String
    let login: RandomUserLogin
    let dob: RandomUserDateOfBirth
    let registered: RandomUserRegistrationDate
    let phone: String
    let cell: String
    let id: RandomUserId?
    let picture: RandomUserImageInformation
    let nat: String
}

struct RandomUserImageInformation: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct RandomUserId: Codable {
    let name: String
    let value: String?
}

struct RandomUserName: Codable {
    let title: String
    let first: String
    let last: String
    
    var formattedName: String {
        return [title,first,last].map({$0.capitalized}).joined(separator: " ")
    }
}

struct RandomUserLocation: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String?
    let coordinates: RandomUserLocationCoordinates

    struct RandomUserLocationCoordinates: Codable {
        let latitude: String
        let longitude: String
    }
    
    let timezone: RandomUserLocationTimezone
    
    struct RandomUserLocationTimezone: Codable {
        let offset: String
        let description: String
    }
    
    var formattedLocaleInfo: String {
        var stringComponents: [String] = []
        stringComponents.append([city,state].map({$0.capitalized}).joined(separator: ", "))
        if let postCodeToInclude = postcode {
            stringComponents += [" ",postCodeToInclude]
        }
        return stringComponents.joined()
    }
}

struct RandomUserRegistrationDate: Codable {
    let date: String
    let age: Int
}

struct RandomUserLogin: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct RandomUserDateOfBirth: Codable {
    let date: Date
    let age: Int
    
    var formattedDate: String {
        return date.formatDateAs(format: "MMMM d, yyyy")
    }
    
}

struct RandomUserLocationCoordinates: Codable {
    let latitude: Double
    let longitude: Double
}
