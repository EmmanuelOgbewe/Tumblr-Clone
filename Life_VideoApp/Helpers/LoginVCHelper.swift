//
//  LoginVCHelper.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 11/15/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//
// This class is a helper class for the LoginVC. It contains some components needed
// in that class

import Foundation
import UIKit
class LoginVCHelper {
    
    var view = UIView()
    
    let emailTextField : UITextField = {
        let text = UITextField()
        text.textColor = UIColor.white
        text.placeholder = "email"
        text.font = UIFont(name: "Avenir-Medium", size: 20)
        text.autocorrectionType = .no
        text.keyboardAppearance = .dark
        text.translatesAutoresizingMaskIntoConstraints = false
        text.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        
        return text
    }()
    
    let usernameTextField : UITextField = {
        let text = UITextField()
        text.textColor = UIColor.white
        text.placeholder = "username"
        text.font = UIFont(name: "Avenir-Medium", size: 20)
        text.autocorrectionType = .no
        text.keyboardAppearance = .dark
        text.translatesAutoresizingMaskIntoConstraints = false
        text.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        return text
    }()
    
    let passwordTextField : UITextField = {
        let text = UITextField()
        text.textColor = UIColor.white
        text.font = UIFont(name: "Avenir-Medium", size: 20)
        text.placeholder = "password"
        text.autocorrectionType = .no
        text.keyboardAppearance = .dark
        text.isSecureTextEntry = true 
        text.translatesAutoresizingMaskIntoConstraints = false 
        text.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        return text
    }()
    
    let forgotButton : UIButton = {
        let button = UIButton()
        button.setTitle("Forgot your password?", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)
        button.titleLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
        button.titleLabel?.contentMode = .left
        return button
    }()
    
    let topLogin : UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 18)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let stack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let errorView : UIButton = {
        let button  = UIButton()
        button.setTitle("Sorry no account found, Please try again", for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont(name: "Avenir-Meium", size: 14)
        return button
    }()
    
    static func showAlert(message : String, vc: UIViewController){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (nil) in
            alert.dismiss(animated:true, completion: nil)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
//
}
