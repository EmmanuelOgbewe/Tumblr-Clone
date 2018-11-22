//
//  EnterPasswordVC.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 11/15/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//

import UIKit

class EnterPasswordVC: UIViewController {
    
    var username: UITextField!
    var email : UITextField!
    var password : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
    // Layout
    func setUpLayout(){
        
        let helper = LoginVCHelper()
        let loginVC = LoginVC()
        let nextButton = helper.topLogin
        let stack = helper.stack
        let backButton = loginVC.backButton
        let tumblrIcon = loginVC.tumblrIcon
        username = helper.usernameTextField
        email = helper.emailTextField
        password = helper.passwordTextField
        
        view.backgroundColor = UIColor(rgb: 0x36465D)
        email.becomeFirstResponder()
        view.addSubview(stack)
        view.addSubview(tumblrIcon)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        
         stack.addArrangedSubview(username)
        stack.addArrangedSubview(email)
        stack.addArrangedSubview(password)
        
        print(username.text!)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(EnterPasswordVC.signUp), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(EnterPasswordVC.goBack), for: .touchUpInside)
        
        backButton.isHidden = false
        
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        [
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
            
            ].forEach{$0.isActive = true}
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        [
            nextButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:   -10)
            ].forEach{$0?.isActive = true }
        
        [
            tumblrIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            tumblrIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tumblrIcon.heightAnchor.constraint(equalToConstant: 30),
            tumblrIcon.widthAnchor.constraint(equalToConstant: 30)
            
            
            ].forEach{$0?.isActive = true}
        
        [
            email.heightAnchor.constraint(equalToConstant: 35),
            password.heightAnchor.constraint(equalToConstant: 35),
            stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 40),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ].forEach{$0?.isActive = true}
        
    }
    @objc func signUp() {
        let feedVC = FeedVC()
        let loginVC = LoginVC()
        if (!email!.text!.isEmpty && !password!.text!.isEmpty && !username.text!.isEmpty){
            AuthService.signUp(username: username.text!, password: password.text!, email: email.text!, onSuccess: {
                self.presentingViewController?.modalTransitionStyle = .crossDissolve
                self.present(feedVC, animated: true, completion: nil)
            }, onError: { (err) in
                LoginVCHelper.showAlert(message: err!, vc: self)
            })
        }else{
             LoginVCHelper.showAlert(message: "Please fill out all fields", vc: self)
        }
    }
    @objc func goBack(){
        let login = LoginVC()
        view.endEditing(true)
        presentingViewController?.modalTransitionStyle = .crossDissolve
        self.present( login, animated: false, completion: nil)
    }
    
}
