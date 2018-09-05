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

extension UIImageView {
    
    func assignImage(with urlString: String){
        DispatchQueue.global().async {
            do {
                guard let url = URL(string: urlString) else { throw ImageHelperError.invalidUrl(msg: urlString) }
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
