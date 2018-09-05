//
//  RandomUserTableCell.swift
//  ShowbieCodingChallenge
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import UIKit

class RandomUserTableCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.clipsToBounds = true
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = UIColor.blue.cgColor
        userImageView.layer.cornerRadius = userImageView.bounds.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with randomUser: RandomUser){
        userImageView.assignImage(with: randomUser.picture.thumbnail)
        nameLabel.text = randomUser.name.first
        emailLabel.text = randomUser.email
        phoneLabel.text = randomUser.cell
    }
    
}
