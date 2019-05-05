//
//  FollowVC.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 21/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Firebase


private let identifier = "Identifier"

class FollowVC : UITableViewController{
    
    var followers = false
    var following = false
    var uid:String?
    var users = [User]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FollowCell.self, forCellReuseIdentifier: identifier)
        
        
        
        //config navbar item
        if followers{
             navigationItem.title = "Followers"
        }
        else{
            navigationItem.title = "Following"
        }
        
        fetchUsers()
       
    }
    
    func fetchUsers(){
        
        
        guard let uid = self.uid else {return}
        
        
        
        var ref : DatabaseReference!
        
        if following{
           ref = USER_FOLLOWING_REF
        }
        else{
            ref = USER_FOLLOWER_REF
        }
       
        ref.child(uid).observeSingleEvent(of: .value) { (snapshot) in
         
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            allObjects.forEach({ (snapshot) in
                
                let userID = snapshot.key
                print(userID)
                
                Database.fetchUSer(with: userID, completion: { (user) in
                    self.users.append(user)
                    self.tableView.reloadData()
                    
                })
                
                
            })
            
            
          
            
            
            
           
            
        }
        
       
    }
    
}

// confirm protocol


extension FollowVC : FollowCellDelegate{
    
    func handleFollowBUttonTapped(for cell: FollowCell) {
     
        guard let user = cell.user else{return}
        
        if user.isFollowed{
            user.unfollow()
            cell.followButton.setTitle("Follow", for: .normal)
            cell.followButton.setTitleColor(.black, for: .normal)
            cell.followButton.layer.borderWidth = 0.5
            cell.followButton.backgroundColor = UIColor(red: 17/154, green: 154/255, blue: 237/255, alpha: 1)
            cell.followButton.layer.borderColor = UIColor.lightGray.cgColor
            
        }else{
            
            user.follow()
            cell.followButton.setTitle("Following", for: .normal)
            cell.followButton.setTitleColor(.black, for: .normal)
            cell.followButton.layer.borderWidth = 0.5
            cell.followButton.backgroundColor = .white
            cell.followButton.layer.borderColor = UIColor.lightGray.cgColor
            
        }
      
    }
}



// table config
extension FollowVC{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if  let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FollowCell {
       cell.delegate = self
   cell.user = self.users[indexPath.row]
        
        return cell
        
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = users[indexPath.row]
        
        
    let userProfileVC  = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileVC.user = user
      navigationController?.pushViewController(userProfileVC, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
