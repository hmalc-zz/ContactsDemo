//
//  ImageHelper.swift
//  ShowbieCodingChallenge
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum ImageHelperError: Error {
    case invalidUrl(msg: String)
}

enum ImageSize {
    case large
    case medium
    case thumbnail
}

extension UIImageView {
    
    func assignImage(for randomUser: RandomUser, imageSize: ImageSize? = .thumbnail){
        switch randomUser.gender {
        case "male":
            self.image = #imageLiteral(resourceName: "malePlaceholder")
        case "female":
            self.image = #imageLiteral(resourceName: "femalePlaceholder")
        default: break
        }
        var urlString: String?
        if let imageSizeToAssign = imageSize {
            switch imageSizeToAssign {
                case .large:
                urlString = randomUser.picture.large
            case .medium:
                urlString = randomUser.picture.medium
            case .thumbnail:
                urlString = randomUser.picture.thumbnail
            }
        }
        DispatchQueue.global().async {
            do {
                guard let urlStringForImage = urlString, let url = URL(string: urlStringForImage) else { throw ImageHelperError.invalidUrl(msg: urlString ?? "Nil URL String") }
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            catch let error {
                print(error)
            }
        }
    }
}
