//
//  FeedVC.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 18/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
configLogoutButton()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

 

}



extension FeedVC {
    
    func configLogoutButton(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        
    }
    
  @objc func handleLogout(){
    
    print("log out")
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (_) in
      
        do {
            try Auth.auth().signOut()
            let loginVC = LoginVC()
            let navigationController = UINavigationController(rootViewController: loginVC)
            self.present(navigationController, animated: true, completion: nil)
            
            
        }catch{
          print("error  logout")
        }
        
        
    }))
   alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
   present(alertController, animated: true, completion: nil)
    
        
        
    }
}
