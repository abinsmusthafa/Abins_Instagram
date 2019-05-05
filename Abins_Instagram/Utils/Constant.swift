//
//  Constant.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 20/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import Firebase

// MARK: - Root References
let DB_REF = Database.database().reference()
let STORAGE_REF = Storage.storage().reference()


// MARK: - Storage References
let STORAGE_PROFILE_IMAGES_REF = STORAGE_REF.child("profile_images")
let USER_REF = DB_REF.child("user")
let USER_FOLLOWER_REF = DB_REF.child("user-followers")
let USER_FOLLOWING_REF = DB_REF.child("user-following")
