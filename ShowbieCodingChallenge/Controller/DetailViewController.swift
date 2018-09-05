//
//  DetailViewController.swift
//  ShowbieCodingChallenge
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

protocol UserDataEntryDelegate {
    func shouldUpdateValidEmail(emailString: String)
    func shouldResetEmail()
}

import UIKit

class DetailViewController: UIViewController {

    var userDataEntryDelegate: UserDataEntryDelegate?
    
    var user: RandomUser? {
        didSet {
            //configureView()
        }
    }
    
    @IBOutlet weak var userImageView: UserImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailEntryTextField: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTextField()
    }
    
    func configureTextField(){
        emailEntryTextField.addTarget(self, action: #selector(DetailViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        emailEntryTextField.layer.borderWidth = 2
        emailEntryTextField.layer.cornerRadius = emailEntryTextField.bounds.size.height/2
        emailEntryTextField.clipsToBounds = true
    }
    
    func configureView() {
        configureAppearance(displayUser: self.user != nil)
        guard let userDetail = self.user else { configureInititalView(); return }
        userImageView.assignImage(for: userDetail, imageSize: .large)
        nameLabel.text = userDetail.name.formattedName
        emailEntryTextField.text = userDetail.email
        
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
                                          emailEntryTextField,
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

extension DetailViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            emailEntryTextField.backgroundColor = UIColor.white
            return
        }
        let backgroundColorToAssign = text.isValidEmail() ? UIColor.cyan : UIColor.red
        emailEntryTextField.layer.borderColor = backgroundColorToAssign.cgColor
        if text.isValidEmail() {
            userDataEntryDelegate?.shouldUpdateValidEmail(emailString: text)
        } else {
            userDataEntryDelegate?.shouldResetEmail()
        }
    }

    
}

