//
//  MainTabVC.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 18/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Firebase
class MainTabVC: UITabBarController , UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
self.delegate = self
       configViewController()
        checkUserLoggedIn()
    }
    

    func configViewController(){
        //home vc
        let feedVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // search vc
        
        let searchVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchVC())
        
        
        // selcet image vc
        let selectImageVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        //uploadPostVC
       // let uploadPostVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: UploadPostVC())
        
        // notificationVC
        
        let notificationVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationVC())
        
        //userprofile VC
        
        let userprofileVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        viewControllers = [feedVC,searchVC,selectImageVC,notificationVC,userprofileVC]
        
        tabBar.tintColor = .black
    }
   
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2{
            let selectImageVC = SelectImageVC(collectionViewLayout: UICollectionViewFlowLayout())
            
            let navigationController = UINavigationController(rootViewController: selectImageVC)
            navigationController.navigationBar.tintColor  = .black
            present(navigationController,animated: true,completion: nil)
            return false
        }
        
        return true
        
        
        
    }
    
    
    
    func constructNavController(unselectedImage : UIImage , selectedImage : UIImage , rootViewController : UIViewController = UIViewController() ) -> UINavigationController {
        
        let navController  =  UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        return navController
    }
   
    func checkUserLoggedIn(){
        
        if Auth.auth().currentUser == nil{
           
            let loginVC = LoginVC()
            let navigationController  = UINavigationController(rootViewController: loginVC)
            present(navigationController, animated: true, completion: nil)
            
            
            
        }
        
    }
    
    

}
