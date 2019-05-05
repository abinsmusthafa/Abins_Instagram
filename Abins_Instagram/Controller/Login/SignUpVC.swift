//
//  SignUpVC.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 17/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    var imageSelcted = false
    let photoPlusButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleSelectProfilePhoto), for: .touchUpInside)
        
        
       return button
        
    
    }()
    
    let emailTextFeild : UITextField = {
       let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        tf.borderStyle = .roundedRect
        return tf
    }()
    let fullNameTextField : UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Full Name"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
        }()
    
    let userNameTextField : UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "User Name"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
         tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    let passwordTextField : UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let signUpButton : UIButton = {
       let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        button.isEnabled = false
        return button
        
    }()
    
    
    
    let alredyHaveAccountButton : UIButton = {
        let button  = UIButton()
        
        let attributedTitle = NSMutableAttributedString(string: "Alredy have an Account?   ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(photoPlusButton)
        
        photoPlusButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 140, height: 140)
        
        photoPlusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        view.addSubview(alredyHaveAccountButton)
        alredyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 0, height: 50)
        
        
configureViewComponets()
        // Do any additional setup after loading the view.
    }

    
    
    @objc func formValidation (){
        
        guard
            emailTextFeild.hasText,
            passwordTextField.hasText,
        userNameTextField.hasText,
        fullNameTextField.hasText,
        imageSelcted == true
        else{
                signUpButton.isEnabled = false
                signUpButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1.0)
                
                return
        }
        
        signUpButton.isEnabled = true
         signUpButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1.0)
        
        
    }
    
    
    @objc func signUpButtonClicked(){
       
        guard let email = emailTextFeild.text else{return}
        guard let password = passwordTextField.text else{return}
        guard let userName = userNameTextField.text?.lowercased() else{return}
        guard let fullName = fullNameTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            // handle error
            
            if let error = error{
                
                print("error for create accoutn",error.localizedDescription)
                return
            }
            
            //sucess
            
            // set up profile image
            guard let uid = user?.user.uid else{return}
            guard let profileImg = self.photoPlusButton.imageView?.image else{return}
            
            guard let uploadData = profileImg.jpegData(compressionQuality: 0.3) else{return}
            
            let filename = NSUUID().uuidString
            
           // ref for storage
            let storageRef = Storage.storage().reference().child("profile_images").child(filename)
            
            // upload profileImg to storage
            storageRef.putData(uploadData, metadata: nil, completion: { (metaData, error) in
                if let error = error{
                    print("uploadignImage faild",error.localizedDescription)
                    
                }
                //get URL of Profileimage Swift 5.0
                storageRef.downloadURL(completion: { (downloadUrl, error) in
                    if let error = error {
                        print("error while getting URL",error.localizedDescription)
                        return
                    }
                    guard let profileImgURl = downloadUrl?.absoluteString else{
                        print("Profile image is nill ")
                        return
                    }
                    
                    let dictionaryValue = [ "name" : fullName,
                                            "username" : userName,
                                            "profileImgURl" : profileImgURl
                    
                    ]
                    
                    let value = [uid : dictionaryValue]
                    
                    Database.database().reference().child("user").updateChildValues(value, withCompletionBlock: { (error, ref) in
                       
                        
                        guard let mainVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabVC else{return}
                        
                        mainVC.configViewController()
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        
                        
                    })
                    
                    
                })
               
                
                
                
             
                
                
            })
            
            
            
            
           
            
            
            
        }
        
        
    }
    
    
    @objc func  handleShowSignIn(){
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func configureViewComponets(){
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextFeild,fullNameTextField,userNameTextField,passwordTextField,signUpButton])
        
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
    view.addSubview(stackView)
        stackView.anchor(top: photoPlusButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 40, paddingBottom: 0, paddingright: 40, width: 0, height: 240)
    }
    

}
extension SignUpVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @objc func handleSelectProfilePhoto(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.present(imagePicker,animated: true)
        
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage =  info[UIImagePickerController.InfoKey.editedImage] as? UIImage  else{
            imageSelcted = false
            return}
        imageSelcted = true
        photoPlusButton.layer.cornerRadius = photoPlusButton.frame.width / 2
        photoPlusButton.layer.borderColor = UIColor.black.cgColor
        photoPlusButton.layer.borderWidth = 2
        photoPlusButton.layer.masksToBounds = true
        photoPlusButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
