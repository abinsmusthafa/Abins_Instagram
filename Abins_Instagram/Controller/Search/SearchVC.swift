//
//  SearchVC.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 18/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Firebase
private let cellReuseidentifier = "cellReuseidentifier"
class SearchVC: UITableViewController {

    //properties
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // register Cell
        
        tableView.register(SearchUserCell.self, forCellReuseIdentifier: cellReuseidentifier)
        
        
        // seperate insects
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
        fetchUser()
        
    }

    
    
    
    func configNavCOntroller(){
        
        navigationItem.title = "Explore"
        
        
    }
    
    
    func fetchUser(){
        
        Database.database().reference().child("user").observe(.childAdded) { (snapshot) in
            
            
            
              let uid = snapshot.key
            
            Database.fetchUSer(with: uid, completion: { (user) in
                self.users.append(user)
               
                    self.tableView.reloadData()
                
                
                
                
                
                
            })
           
            
            
            
            
        }
        
        
        
        
    }
    

}



extension SearchVC {
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseidentifier, for: indexPath) as? SearchUserCell{
            
            cell.user = users[indexPath.row]
            
            
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // create userPRofileVc
        
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        
        userProfileVC.user = users[indexPath.row]
        
        navigationController?.pushViewController(userProfileVC, animated: true)
        
        
        
    }
}
