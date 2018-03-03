//
//  PostCollectionViewCell.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/21/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    var profileImage: UIImageView!
    var posterText: UILabel!
    var postText: UILabel!
    var interestedButton: UIButton!
    var numberInterested: UILabel!
    var color = Constants.appColor

    
    override func awakeFromNib() {
        super.awakeFromNib()
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        self.backgroundColor = color
        setupProfileImage()
        setupPosterText()
        setupPostText()
        setupInterested()
    }
    func setupInterested() {
        let origImage = UIImage(named: "heartIcon")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        interestedButton = UIButton(frame: CGRect(x: self.contentView.frame.width - 50, y: self.contentView.frame.height - 40, width: 30, height: 30))
        interestedButton.setImage(tintedImage, for: .normal)
        interestedButton.tintColor = UIColor.white
        addSubview(interestedButton)
        
        numberInterested = UILabel(frame: CGRect(x: self.contentView.frame.width - 80, y: self.contentView.frame.height - 40, width: 30, height: 30))
        numberInterested.textColor = UIColor.white
        numberInterested.text = "\(0)"
        addSubview(numberInterested)
    }
    
    func setupProfileImage() {
        profileImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 0.50 * self.contentView.frame.width, height: 0.70 * self.contentView.frame.height))
        profileImage.layer.backgroundColor = UIColor.white.cgColor
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 3
        profileImage.image = UIImage(named: "moreclouds")
        addSubview(profileImage)
    }
    
    func setupPosterText() {
        posterText = UILabel(frame: CGRect(x: profileImage.frame.maxX + 10, y: 10, width: self.contentView.frame.width * 0.5 - 30, height: 50))
        posterText.backgroundColor = UIColor(patternImage: UIImage(named: "image")!)
        posterText.textColor = UIColor.black
        posterText.layer.borderColor = UIColor.white.cgColor
        posterText.layer.borderWidth = 3
        posterText.font = UIFont(name: "Strawberry Blossom", size: 25)
        posterText.textAlignment = .center
        posterText.adjustsFontForContentSizeCategory = true
        addSubview(posterText)
    }
    
    func setupPostText() {
        postText = UILabel(frame: CGRect(x: profileImage.frame.maxX + 10, y: posterText.frame.maxY + 10, width: self.contentView.frame.width * 0.5 - 30, height: 0.5 * self.frame.height - 20))
        postText.backgroundColor = UIColor(patternImage: UIImage(named: "image")!)
        postText.font = UIFont(name: "Strawberry Blossom", size: 30)
        postText.textColor = UIColor.black
        postText.layer.borderWidth = 3
        postText.layer.borderColor = UIColor.white.cgColor
        postText.numberOfLines = 0
        postText.textAlignment = .center
        postText.adjustsFontSizeToFitWidth = true
        addSubview(postText)
    }
    
}
