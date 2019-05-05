//
//  SearchUserCell.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 19/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Kingfisher

class SearchUserCell: UITableViewCell {

    var user : User? {
        
        didSet{
          
            guard let imageUrl = user?.profileImgURl else {
                return
            }
            guard let userName = user?.username else{return}
            guard let fullName = user?.name else{return}
            
            
            
         userProfileImageView.kf.setImage(with: URL(string: imageUrl))
            self.textLabel?.text = userName
self.detailTextLabel?.text = fullName
            
        }
        
    }
    
    
    
    
    let userProfileImageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = ContentMode.scaleAspectFill
        iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(userProfileImageView)
        userProfileImageView.anchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 14, paddingBottom: 0, paddingright: 0, width: 48, height: 48)
        userProfileImageView.layer.cornerRadius = 48/2
        
        userProfileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.textLabel?.text = "Username"
        self.detailTextLabel?.text  = "Full Name"
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.frame = CGRect(x: 68, y: (textLabel?.frame.origin.y)! - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        
        self.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.detailTextLabel?.frame = CGRect(x: 68, y: (detailTextLabel?.frame.origin.y)!, width: (self.frame.width ) - 108, height: (detailTextLabel?.frame.height)!)
        self.detailTextLabel?.textColor = .lightGray
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
