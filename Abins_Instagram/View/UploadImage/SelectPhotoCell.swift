//
//  SelectPhotoCell.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 23/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit

class SelectPhotoCell: UICollectionViewCell {
    
    
    let photoImageImageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        //iv.image = #imageLiteral(resourceName: "Avatar")
       // iv.layer.cornerRadius =  self.conten
        iv.contentMode = ContentMode.scaleAspectFill
        //iv.backgroundColor = .lightGray
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //contentView.backgroundColor = .red
        
        
        
        addSubview(photoImageImageView)
        
        
        photoImageImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 0, height: 0    )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//
//    override func layoutSubviews() {
//        self.contentView.layer.cornerRadius = 20
//        self.contentView.layer.borderWidth = 1.0
//        self.contentView.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.layer.masksToBounds = true
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//   }
    
}
