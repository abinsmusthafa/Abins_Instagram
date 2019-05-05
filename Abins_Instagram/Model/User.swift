//
//  User.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 18/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//
import Firebase
class User{
    var uid : String!
    var username : String!
    var name : String!
    var profileImgURl : String!
     var isFollowed = false
    init(uid : String , dictionary: Dictionary<String,AnyObject>) {
        
         self.uid = uid
        
        
        if let username = dictionary["username"] as? String{
            self.username = username
        }
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let profileImgURl = dictionary["profileImgURl"] as? String{
            self.profileImgURl = profileImgURl
        }
    }
    
  
    
    
    func follow(){
        self.isFollowed = true
        guard let CurrentUserID = Auth.auth().currentUser?.uid else {
            return
        }
         guard let uid = uid else { return }
        
        USER_FOLLOWING_REF.child(CurrentUserID).updateChildValues([uid:1])
        USER_FOLLOWER_REF.child(uid).updateChildValues([CurrentUserID:1])
        
        
        
    }
    
    
    func unfollow(){
        self.isFollowed = false
        guard let CurrentUserID = Auth.auth().currentUser?.uid else {
            return
        }
         guard let uid = uid else { return }
        
        USER_FOLLOWING_REF.child(CurrentUserID).child(uid).removeValue()
        USER_FOLLOWER_REF.child(uid).child(CurrentUserID).removeValue()
        
        
        
        
    }
    
    
    // this func call when load the profile page and check current user follow or not the user
    func checkIfUserIsFollowed( completion : @escaping (Bool) ->()){
        
        guard let CurrentUserID = Auth.auth().currentUser?.uid else {return}
        
        USER_FOLLOWING_REF.child(CurrentUserID).observeSingleEvent(of: .value) { (snapshot) in
            
            if snapshot.hasChild(self.uid){
                
                self.isFollowed = true
                completion(true)
                
                
            }
            else {
                self.isFollowed = false
                completion(false)
                
            }
            
        }
        
        
    }
    
}

