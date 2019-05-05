//
//  SelectPhotoHeader.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 23/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit

class SelectPhotoHeader: UICollectionViewCell {
    
 
    
    
    let selectedPhotoImageImageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = ContentMode.scaleAspectFill
       
        return iv
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(selectedPhotoImageImageView)
        selectedPhotoImageImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 0, height: 0    )
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
