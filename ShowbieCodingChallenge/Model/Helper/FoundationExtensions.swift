//
//  FoundationExtensions.swift
//  ShowbieCodingChallenge
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import Foundation

extension Date {
    
    func formatDateAs(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
