//
//  DetailViewController.swift
//  ShowbieCodingChallenge
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

protocol UserDataEntryDelegate {
    func shouldUpdateValidEmail(emailString: String)
}

import UIKit

class DetailViewController: UIViewController {

    var user: RandomUser? {
        didSet {
            //configureView()
        }
    }
    
    @IBOutlet weak var userImageView: UserImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    func configureView() {
        configureAppearance(displayUser: self.user != nil)
        guard let userDetail = self.user else { configureInititalView(); return }
        userImageView.assignImage(for: userDetail, imageSize: .large)
        nameLabel.text = userDetail.name.formattedName
        emailLabel.text = userDetail.email
        phoneLabel.text = userDetail.cell
        
        streetAddressLabel.text = userDetail.location.street.capitalized
        localLabel.text = userDetail.location.formattedLocaleInfo
        birthdayLabel.text = "Birthday: " + userDetail.dob.formattedDate
        ageLabel.text = "Age: " + "\(userDetail.dob.age)"
    }
    
    func configureInititalView(){
        detailDescriptionLabel.text = "Select a user to see their information"
    }
    
    func configureAppearance(displayUser: Bool){
        let userRelatedViews: [UIView] = [nameLabel,
                                          emailLabel,
                                          phoneLabel,
                                          streetAddressLabel,
                                          localLabel,
                                          phoneLabel,
                                          birthdayLabel,
                                          ageLabel,
                                          userImageView]
        userRelatedViews.forEach({$0.isHidden = !displayUser})
        detailDescriptionLabel.isHidden = displayUser
    }


}

