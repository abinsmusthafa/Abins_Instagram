//
//  UserProfileVC.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 18/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifier = "UserProfileHeader"

class UserProfileVC: UICollectionViewController ,UICollectionViewDelegateFlowLayout{

    var user : User?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
collectionView.backgroundColor = .white
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // register header
        
        self.collectionView!.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        
       
        // fetch daTA check if the data come from search VC?
        
        if user == nil {
            fechUserdata()

        }
        
        
       
    }

    func fechUserdata(){
        guard  let currentUserID = Auth.auth().currentUser?.uid else{return}
        
        Database.database().reference().child("user").child(currentUserID).observeSingleEvent(of: .value) { (snapshot) in
            
            let uid = snapshot.key
            
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else{return}
            
            let user = User(uid: uid, dictionary: dictionary)
            self.user = user
            
            self.collectionView.reloadData()
            self.navigationItem.title = user.username
       
}

}

}

extension  UserProfileVC {
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //declare and retunr header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
        
      header.delegate = self
            
header.user = self.user
        
        navigationItem.title = user?.username
            
           
       
        
       
       return header
    }
        
        
}
    

// MARK : -  UserProfileHeaderDelegate
extension UserProfileVC: UserProfileHeaderDelegate{
    func handleFollowersTapped(for header: UserProfileHeader) {
        let followVC = FollowVC()
        followVC.followers = true
        followVC.uid = self.user?.uid
        navigationController?.pushViewController(followVC, animated: true)
        
    }
    
    func handleFollowingTapped(for header: UserProfileHeader) {
        let followVC = FollowVC()
        followVC.following = true
        followVC.uid = self.user?.uid
        navigationController?.pushViewController(followVC, animated: true)
    }
    
    func setUserStatus(for header: UserProfileHeader) {
        
        guard let uid = header.user?.uid else {
            return
        }
        
        var numberOffollowing :Int!
        var numberOfFollowers : Int!
        
        //get number of following
        USER_FOLLOWING_REF.child(uid).observe(.value) { (snapshot) in
            
            if let snapshot = snapshot.value as? [String:AnyObject] {
                
                numberOffollowing = snapshot.count
                
            }
            else{
                numberOffollowing = 0
            }
            
            let attributedText = NSMutableAttributedString(string: "\(numberOffollowing!)\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
            header.followingLbl.attributedText = attributedText
            
        }
        
        
        // get number of followers
        
        
        USER_FOLLOWER_REF.child(uid).observe(.value) { (snapshot) in
            
            if let snapshot = snapshot.value as? [String:AnyObject] {
                numberOfFollowers = snapshot.count
                
            }
            else{
                numberOfFollowers = 0
            }
            
            let attributedText = NSMutableAttributedString(string: "\(numberOfFollowers!)\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "Followers", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
            header.followersLbl.attributedText = attributedText
            
        }
        
        
        
        
        
        
    }
    
    
    
    func handleEditProfileFollowTapped(for header: UserProfileHeader) {
        
        guard let user = header.user else {
            return
        }
        
        if header.editProfileFollowButton.titleLabel?.text == "Follow"{
            header.editProfileFollowButton.setTitle("Following", for: .normal)
            
            user.follow()
            
            
        }else{
            
            header.editProfileFollowButton.setTitle("Follow", for: .normal)
            
            user.unfollow()
        }
        
    }
    
    
    
}
