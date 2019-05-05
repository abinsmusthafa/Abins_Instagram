//
//  UserProfileHeader.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 18/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase
class UserProfileHeader: UICollectionViewCell {
    
    
    var delegate: UserProfileHeaderDelegate?
    
    
    var user : User? {
       
        didSet{
            
            setUserStatus(for: user)
            
            configeditProfileFollowButton()
            
            let fullname = user?.name
            userNameLbl.text = fullname
            
            guard let profileImgURls = user?.profileImgURl else {
                
                return
            }
            
            
            guard  let url = URL(string: profileImgURls) else {
                return
            }
            
            userProfileImageView.kf.indicatorType = .activity
            let image = UIImage(named: "Avatar")
            //let resource = ImageResource(downloadURL: URL(string: profileImgURls)!, cacheKey: "my_cache_key")
            userProfileImageView.kf.setImage(with: url ,placeholder: image)
            
            
            
        }
        
    }
    
    
    let userProfileImageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = ContentMode.scaleAspectFill
        iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    
    let userNameLbl : UILabel = {
        
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
        
    }()
    
    let postLbl : UILabel = {
        
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
   
    
                return lbl
        
    }()
    lazy var followingLbl : UILabel = {
        
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(handleFollowingLabelTapped))
        tapGuesture.numberOfTapsRequired = 1
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(tapGuesture)
        
        let attributedText = NSMutableAttributedString(string: "\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        lbl.attributedText = attributedText
        
        return lbl
        
    }()
    
    lazy var followersLbl : UILabel = {
        
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(handleFollowersLabelTapped))
        tapGuesture.numberOfTapsRequired = 1
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(tapGuesture)
        let attributedText = NSMutableAttributedString(string: "\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "Followers", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        lbl.attributedText = attributedText
        
        return lbl
        
    }()
   lazy var  editProfileFollowButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Loding..", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    
    
    let gridButton : UIButton = {
       let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
        
    }()
    
    let listButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
        
    }()
    
    let boomarkButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
        
    }()
 
    // MARK : - Handler
    @objc func handleFollowersLabelTapped(){
        
        delegate?.handleFollowersTapped(for: self)
    }
    
    @objc func handleFollowingLabelTapped(){
        
        delegate?.handleFollowingTapped(for: self)
        
    }
    
   @objc func  handleEditProfileFollowTapped(){
    
    //when user click the button follow its controls goes to USerprofile VC delegate and do the code 
        delegate?.handleEditProfileFollowTapped(for: self)
        
    }
    
    
    
    
    func configureBottomToolBar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, boomarkButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        
        addSubview(topDividerView)
        addSubview(stackView)
        addSubview(bottomDividerView)
        
        
         topDividerView.anchor(top: self.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 0, height: 0.5)
        
        stackView.anchor(top: self.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 0, height: 50)
        
       bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 0, height: 0.5)

        
        
      
        
        
        
    }
    func configUserstatus(){
        
        let stackView = UIStackView(arrangedSubviews: [postLbl,followersLbl,followingLbl])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.anchor(top: self.topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingright: 12, width: 0, height: 50)
        
        
        
    }
    func setUserStatus(for user  : User?){
        delegate?.setUserStatus(for: self)
    }
    
    
    
    func  configeditProfileFollowButton(){
        
         //self.editProfileFollowButton.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        
        guard let currentUserID = Auth.auth().currentUser?.uid  else {
            return
        }
        
        
        guard let user = self.user else {
            return
        }
        
        if currentUserID == user.uid{
            editProfileFollowButton.setTitle("Edit Pofile", for: .normal)
            
        }else{
            editProfileFollowButton.setTitleColor(.white, for: .normal)
            editProfileFollowButton.backgroundColor = UIColor(red: 17/154, green: 154/255, blue: 237/255, alpha: 1)
            
            user.checkIfUserIsFollowed { (followed) in
                if followed{
                     self.editProfileFollowButton.setTitle("Following", for: .normal)
                }else{
                    self.editProfileFollowButton.setTitle("Follow", for: .normal)
                }
            }
            
            
           
          
           
        }
        
        
    }
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(userProfileImageView)

        userProfileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingright: 0, width: 80, height: 80)
        userProfileImageView.layer.cornerRadius = 80/2

        addSubview(userNameLbl)
        userNameLbl.anchor(top: userProfileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingright: 0, width: 0, height: 0)

        configUserstatus()


        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: postLbl.bottomAnchor, left: postLbl.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingright: 4, width: 0, height: 30)

        configureBottomToolBar()



    }

    

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
