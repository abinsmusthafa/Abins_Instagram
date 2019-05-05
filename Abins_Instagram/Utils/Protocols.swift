//
//  Protocols.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 20/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import Foundation
import Firebase

protocol UserProfileHeaderDelegate {
    func handleEditProfileFollowTapped(for header : UserProfileHeader)
    func setUserStatus(for header :UserProfileHeader)
    func handleFollowersTapped(for header : UserProfileHeader)
    func handleFollowingTapped(for header :UserProfileHeader)
    
}
protocol FollowCellDelegate {
    func handleFollowBUttonTapped(for cell : FollowCell)
    
    
}


extension Database{
    
    
    static func fetchUSer(with uid : String ,completion : @escaping(User)->()){
        
        
        USER_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
            
        }
    }
    
    
    
}
