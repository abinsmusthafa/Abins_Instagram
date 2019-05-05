//
//  SelectImageVC.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 23/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "SelectPhotoCell"
private let headerIdentifier = "HeaderIdentifier"

class SelectImageVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var images = [UIImage]()
    var assets = [PHAsset]()
    var selectedImage : UIImage?
    var header:SelectPhotoHeader?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fetch fotos
        
        fetchPhotos()
        
        //  navigation controller items setup
        configureNavigationButton()
        
        
        
        
        
        collectionView.backgroundColor = UIColor.white

        collectionView.register(SelectPhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(SelectPhotoHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerIdentifier)

}
    
    // MARK : - hander
    
  @objc func  handleCancel(){
    navigationController?.dismiss(animated: true, completion: nil)
    
    }
 @objc func handleNext(){
    
    let uploadVC = UploadPostVC()
    uploadVC.selectedImage = self.header?.selectedPhotoImageImageView.image
    navigationController?.pushViewController(uploadVC, animated: true)
    
    
    
    
    }
    func configureNavigationButton(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    
    
    
    // getAssetFetchOptions
    
    
    func getAssetFetchOptions () -> PHFetchOptions{
        let options = PHFetchOptions()
        
        // fetch limit
        options.fetchLimit = 30
       //sort photo by data
        let sortDescroptor = NSSortDescriptor(key: "creationDate", ascending: false)
        //set sort descripttor for optios
        options.sortDescriptors? = [sortDescroptor]
   
        return options
        
    }
    
    func fetchPhotos(){
        let allPhotos = PHAsset.fetchAssets(with: .image, options: getAssetFetchOptions())
        
        //fetch images on background thread
        
        DispatchQueue.global(qos: .background).async {
        
            allPhotos.enumerateObjects({ (asset, count, stope) in
               
                
                print("#######\(count)")
             let imageManager = PHImageManager.default()
               let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFit, options: options, resultHandler: { (image, info) in
                    print("@@@@\(count)")
                    if let image = image{
                       //append images to data sourse
                        self.images.append(image)
                    }
                    // append assets to data sourse
                    self.assets.append(asset)
                    
                    if self.selectedImage == nil{
                        self.selectedImage = image
                    }
                    
                    
                    //reload collection view in main thred
                    if count == allPhotos.count - 1{
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                    
                   
                    
                })
                
            })
            
            
            
            
            
            
        }//closing of background thred
        
    }

}



extension SelectImageVC {
        
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }
        
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath  ) as? SelectPhotoCell{
             cell.photoImageImageView.image = images[indexPath.item]
                
                return cell
                
                
                
            }
            
           return UICollectionViewCell()
        }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedImage = images[indexPath.row]
        self.collectionView.reloadData()
        
        
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as? SelectPhotoHeader {
           
            // now can acces header out side
           self.header  = header
            
            
            if let selectedImage = self.selectedImage{
                if let index = self.images.firstIndex(of: selectedImage) {
                  //index of selected image
                    let selectedAsset = self.assets[index]
                    
                    //asset assocaited with selected image
                    
                    let imageManager = PHImageManager.default()
                    let targeetSize = CGSize(width: 600, height: 600)
                    
                    //request to image
                    
                    imageManager.requestImage(for: selectedAsset, targetSize: targeetSize, contentMode: .default, options: nil) { (image, infor) in
                        
                        
                        header.selectedPhotoImageImageView.image = image
                        
                    }
                    
                    
                    
                }
               
            }
            
            return header
        }
        
      return  UICollectionReusableView()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    
    // size for header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = view.frame.width
        return CGSize(width: width, height: width)
        
    }
   
    // size for collection view
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
        
}
