//
//  RandomUserAPIService.swift
//  ShowbieCodingChallenge
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import Foundation

fileprivate enum RandomUserAPIError: Error {
    case invalidInputsError(msg: String)
    case urlSessionError(error: Error)
    case responseHandlingError(msg: String)
    case decodingError(error: Error)
    case invalidMockFile
}

/// A class to manage requesting and decoding data from the RandomUser APi
/// https://randomuser.me/documentation

class RandomUserAPIService {
    
    // MARK: API constants and configuration
    
    typealias RandomUserResponse = (RandomUserAPIResponse?, Error?) -> Void
    
    private static let API_BASE_URL = "https://randomuser.me/api/"
    private static let API_TIME_FORMAT = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    fileprivate enum SupportedRandomUserNationalityCode: String {
        case canada = "CA"
        static func getUrlSegment(supportedNationalityCodes: [SupportedRandomUserNationalityCode]) -> String {
            if supportedNationalityCodes.isEmpty { return "" }
            return "nat=" + supportedNationalityCodes.map({$0.rawValue.lowercased()}).joined(separator: ",")
        }
    }
    
    
    /// Url contructor method
    ///
    /// - Parameters:
    ///   - nationalityCodes: An array of countries form which the request would like. `nil` by default and open to all countries
    ///   - multipleResultsRequested: Sets the maximum number of users returned in the request
    /// - Returns: Returns an optional `RandomUserAPIResponse` struct containing all returned data including users and an optional error.
    
    private static func constructUrlForRequest(nationalityCodes: [SupportedRandomUserNationalityCode]? = nil, multipleResultsRequested: Int = 50) -> String {
        let urlString = API_BASE_URL
        var queryToInclude: [String] = []
        if let nationalityCodesToQuery = nationalityCodes {
            queryToInclude.append(SupportedRandomUserNationalityCode.getUrlSegment(supportedNationalityCodes: nationalityCodesToQuery))
        }
        queryToInclude.append("results=\(multipleResultsRequested)")
        return urlString + (queryToInclude.isEmpty ? "" : "?") + queryToInclude.joined(separator: "&")
    }
    
    // MARK: URL Requests
    
    /// Fetch 50 Canadian Users
    ///
    /// - Parameter completion: A `RandomUserResponse` containing up to 50 users from Canada as per API docs
    
    static func fetchCanadianRandomUsers(completion: @escaping RandomUserResponse) -> Void {
        let urlString = constructUrlForRequest(nationalityCodes: [.canada], multipleResultsRequested: 5000)
        guard let url = URL(string: urlString) else {
            completion(nil, RandomUserAPIError.invalidInputsError(msg: "Could not initialise `\(urlString)` as valid URL object"))
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { dataResponse, response, error -> Void in
            if let urlSessionError = error {
                completion(nil, RandomUserAPIError.urlSessionError(error: urlSessionError))
                return
            }
            guard let data = dataResponse else {
                completion(nil,RandomUserAPIError.responseHandlingError(msg: "nil `data` return from request"))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                //let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat = flickrTimeFormat
                //decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let responseString = String(data: data, encoding: .utf8)
                let result = try decoder.decode(RandomUserAPIResponse.self, from: data)
                completion(result,error)
            } catch let error {
                print(error.localizedDescription)
                completion(nil, RandomUserAPIError.decodingError(error: error))
            }
        })
        task.resume()
    }
    
}
