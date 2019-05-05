//
//  FollowCell.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 21/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase
class FollowCell: UITableViewCell {

    var user : User? {
        
        didSet{
            
            guard let imageUrl = user?.profileImgURl else {
                return
            }
            guard let userName = user?.username else{return}
            guard let fullName = user?.name else{return}
            
            detailTextLabel?.text = userName
            textLabel?.text = fullName
            userProfileImageView.kf.setImage(with: URL(string: imageUrl))
            
            if user?.uid == Auth.auth().currentUser?.uid {
                self.followButton.isHidden = true
            }
            
            
            user?.checkIfUserIsFollowed(completion: { (followed) in
                if followed{
                    self.followButton.setTitle("Following", for: .normal)
                    self.followButton.setTitleColor(.black, for: .normal)
                    self.followButton.layer.borderWidth = 0.5
                    self.followButton.backgroundColor = .white
                    self.followButton.layer.borderColor = UIColor.lightGray.cgColor
                }else{
                    
                    self.followButton.setTitle("Follow", for: .normal)
                    self.followButton.setTitleColor(.white, for: .normal)
                    self.followButton.layer.borderWidth = 0
                    self.followButton.backgroundColor = UIColor(red: 17/154, green: 154/255, blue: 237/255, alpha: 1)
                   
                    
                }
                
                
                
            })
            
            
        }
        
        
    }
    
    
    // MARK: - Properties
    var delegate: FollowCellDelegate?
    
    
    let userProfileImageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = ContentMode.scaleAspectFill
        iv.backgroundColor = UIColor.lightGray
        return iv
    }()
  
    lazy var followButton : UIButton = {
       let bt = UIButton(type: .system)
        bt.setTitle("Loading", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = UIColor(red: 17/154, green: 154/255, blue: 237/255, alpha: 1)
        bt.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        return bt
        
    }()
    
    
    // MARK: - handler
    
   // follow button tapped give the handler to followVC
 @objc func handleFollowTapped()
 {
delegate?.handleFollowBUttonTapped(for: self)
}
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
       addSubview(userProfileImageView)
        
        userProfileImageView.anchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 14, paddingBottom: 0, paddingright: 0, width: 48, height: 48)
        userProfileImageView.layer.cornerRadius = 48/2
        
        userProfileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        detailTextLabel?.text = "User name"
        textLabel?.text = "Full name"
        
        addSubview(followButton)
        followButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 16, width: 90, height: 30)
        followButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        followButton.layer.cornerRadius = 3
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    //give the constain for defaults views like detaild labe and text label
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.frame = CGRect(x: 68, y: (textLabel?.frame.origin.y)! - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        
        self.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.detailTextLabel?.frame = CGRect(x: 68, y: (detailTextLabel?.frame.origin.y)!, width: (self.frame.width ) - 108, height: (detailTextLabel?.frame.height)!)
        self.detailTextLabel?.textColor = .lightGray
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        
        
    }

}
