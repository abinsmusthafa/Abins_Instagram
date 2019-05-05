//
//  LoginVC.swift
//  Abins_Instagram
//
//  Created by Abins Musthafa on 17/04/19.
//  Copyright © 2019 Abins Musthafa. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    
    
    let logoContainerView : UIView = {
       let  view = UIView()
        let logoImgView = UIImageView(image: UIImage(named: "Instagram_logo_white")?.withRenderingMode(.alwaysOriginal))
        logoImgView.contentMode = .scaleAspectFill
        view.addSubview(logoImgView)
        
        logoImgView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 200, height: 50)
        
        logoImgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor(red: 0/255, green: 128/255, blue: 175/255, alpha: 1)
        
       return view
    }()
    
    let emailTextField : UITextField = {
      
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidate), for: .editingChanged)
        return tf
    }()

    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(formValidate), for: .editingChanged)
        return tf
        
        
    }()
    
    let signInButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1.0)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
       return button
    }()
    
   
    
    let dontHaveAccountButton : UIButton = {
       
        let button  = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an Account   ", attributes:[ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray ])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //set background color
      view.backgroundColor = .white
        
        //hide nav bar
        navigationController?.navigationBar.isHidden = true
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 0, height: 150)
       configureViewComponets()
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingright: 0, width: 0, height: 50)
//        view.addSubview(emailTextField)
//        emailTextField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingright: 20, width: 0, height: 40)
//
//       print("abins")
    }

    
    
    @objc func handleLogin(){
    
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
            
            // handle error
            if let error  = error {
                print("faild to login" ,error.localizedDescription)
                return
            }
            
         // handle sucess
            
           
            
            
            
            
            
            guard let mainVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabVC else{return}
            
            mainVC.configViewController()
            
            self.dismiss(animated: true, completion: nil)
            
            
            
            
            
            
        }
    
    
    }
    @objc func formValidate() {
        
        guard emailTextField.hasText,
            passwordTextField.hasText
            else {
            signInButton.isEnabled = false
                signInButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1.0)
                return
        }
        
        signInButton.isEnabled = true
       signInButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1.0)
    }
    
    
    @objc func handleShowSignUp(){
        
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
        
    }
    
    
    func configureViewComponets(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,signInButton])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        view.addSubview(stackView)
        
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingright: 40, width: 0, height: 140)
        
    }
    
    
}
