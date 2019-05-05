//
//  Utils.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 17/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit


extension UIView {
    
    func anchor(top:NSLayoutYAxisAnchor?, left:NSLayoutXAxisAnchor? , bottom:NSLayoutYAxisAnchor? , right:NSLayoutXAxisAnchor?, paddingTop:CGFloat, paddingLeft : CGFloat,paddingBottom:CGFloat,paddingright:CGFloat,width:CGFloat,height:CGFloat )  {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right{
            self.rightAnchor.constraint(equalTo: right, constant: -paddingright).isActive = true
        }
        
        if width != 0{
            widthAnchor.constraint(equalToConstant: width).isActive  = true
        }
        
        if height != 0{
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
    
}


