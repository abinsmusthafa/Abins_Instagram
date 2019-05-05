//
//  UploadPostVC.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 18/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit

class UploadPostVC: UIViewController {

    var selectedImage : UIImage?
    
    
    let uploadimageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    let captionTextView : UITextView = {
        
        let tv = UITextView()
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.font = UIFont.systemFont(ofSize: 12)
        
       return tv
    }()
    
    lazy var shareButton : UIButton = {
       let bt = UIButton()
        bt.setTitle("Share", for: .normal)
        bt.backgroundColor = UIColor(red: 204/255, green: 244/255, blue: 244/255, alpha: 1)
        bt.setTitleColor(.white, for: .normal)
        bt.layer.cornerRadius = 5
        return bt
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
       configViewComponets()
       loadImage()
        
    }
    
  func configViewComponets(){
    view.addSubview(uploadimageView)
    
    uploadimageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 92, paddingLeft: 12, paddingBottom: 0, paddingright: 0, width:100 , height: 100)
    view.addSubview(captionTextView)
    captionTextView.anchor(top: view.topAnchor, left: uploadimageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 92, paddingLeft: 12, paddingBottom: 0, paddingright: 12, width: 0, height: 100)
    view.addSubview(shareButton)
    
    shareButton.anchor(top: uploadimageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 24, paddingBottom: 0, paddingright: 24, width: 0, height: 40)
    }
    
    
    func loadImage(){
        guard let selectedImage = self.selectedImage else{return}
        uploadimageView.image = selectedImage
        
    }

}
