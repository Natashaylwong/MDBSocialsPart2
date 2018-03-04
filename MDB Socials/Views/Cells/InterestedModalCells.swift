//
//  InterestedModalCells.swift
//  MDB Socials
//
//  Created by Natasha Wong on 3/2/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit
import ChameleonFramework


class InterestedModalCells: UITableViewCell {

    var userImageView: UIImageView!
    var usernameLabel: UILabel!
    var nameLabel: UILabel!
    var color = Constants.appColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var font = UIFont(name: "Strawberry Blossom", size: 50)
        userImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 60, height: 60))
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 30
        addSubview(userImageView)
        
//        usernameLabel = UILabel(frame: CGRect(x: 90, y: 5, width: 200, height: 25))
//        usernameLabel.textColor = color
//        usernameLabel.font = UIFont.systemFont(ofSize: 18)
//        addSubview(usernameLabel)
        
        nameLabel = UILabel(frame: CGRect(x: 100, y: 10, width: 200, height: 50))
        nameLabel.textColor = UIColor.gray
        nameLabel.font = font
        addSubview(nameLabel)
    }
}
