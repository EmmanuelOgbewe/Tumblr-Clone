//
//  LoginVC.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 11/13/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //Components
    let backgroundImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "paulo-silva-575922-unsplash")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let opacityView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    let tumblrIcon : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "tumblr")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let phrase : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Avenir-Black", size: 25)
        label.text = "Explore mind-blowing stuff."
        label.textColor = UIColor.white
        return label
    }()
    
    var loginButton : UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 200, height: 45)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        
        return button
    }()
    
    var textField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.textColor = UIColor.white.withAlphaComponent(0.7)
        
        textField.keyboardAppearance = .dark
        textField.keyboardType = .default
        textField.font = UIFont(name: "Avenir-Medium", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        return textField
    }()
    
    var getStarted : UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(rgb:0x529ECD)
        
        return button
    }()
    
    var buttonStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let username : UILabel = {
        let label = UILabel()
        let username = "Posted by erik-blad"
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        let stringToColor = "erik-blad"
        let range = (username as NSString).range(of:stringToColor)
        let attribute = NSMutableAttributedString.init(string: username)
        attribute.addAttributes([NSAttributedString.Key.font : UIFont(name: "Avenir-Heavy", size: 12)!, NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.7) ], range: range)
        label.attributedText = attribute
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"convo_back"), for: .normal)
        button.frame.size = CGSize(width: 25, height: 25)
        button.imageView?.clipsToBounds = true
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let errorView : UIButton = {
        let button  = UIButton()
        button.setTitle("Please fill out the above field", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.contentMode = .center
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.font = UIFont(name: "Avenir-Bold", size: 12)
        if let title = button.titleLabel?.text{
            button.setAttributedTitle(title.getUnderLineAttributedText(), for: .normal)
        }
        return button
    }()
    //--End Components
    
    //Constraints
    var tumblrTopAnchor : NSLayoutConstraint!
    var buttonStackBottomAnchor : NSLayoutConstraint!
    var loginButtonHeight : NSLayoutConstraint!
    var usernameBottomAnchor : NSLayoutConstraint!
    var loginPressed = false
    var topErrorViewConstraint : NSLayoutConstraint!
    var errorTopAnchor : NSLayoutConstraint!
    
    //Credentials
    var emailTextField : UITextField?
    var passwordTextField : UITextField?
    var forgotButton : UIButton?
    var topLoginButton: UIButton?
    var cStack : UIStackView?
    var signUpVC = EnterPasswordVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpLayout()
        addButtonTargets()
        self.view.backgroundColor = UIColor(rgb:0x36465D)
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.clear
        textField.delegate = self
        keyboardNotifications()
    }
    //Layout
    func setUpLayout(){
        
       
        
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(opacityView)
        view.addSubview(backButton)
        view.addSubview(tumblrIcon)
        opacityView.addSubview(phrase)
        view.addSubview(buttonStack)
        view.addSubview(username)
        view.addSubview(errorView)
        
        buttonStack.addArrangedSubview(textField)
        buttonStack.addArrangedSubview(getStarted)
        buttonStack.addArrangedSubview(loginButton)
        

        topLoginButton?.isEnabled = true
        topLoginButton?.setTitleColor(UIColor.blue, for: .normal)
        
        topLoginButton?.alpha = 0
        textField.alpha = 0
        errorView.alpha = 0
        
        
        [
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ].forEach{$0.isActive = true}
        [
            opacityView.topAnchor.constraint(equalTo: view.topAnchor),
            opacityView.leftAnchor.constraint(equalTo: view.leftAnchor),
            opacityView.rightAnchor.constraint(equalTo: view.rightAnchor),
            opacityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ].forEach{$0.isActive = true}
        
        [
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
            ].forEach{$0.isActive = true}
        
        tumblrTopAnchor = tumblrIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        [
            tumblrTopAnchor,
            tumblrIcon.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            tumblrIcon.heightAnchor.constraint(equalToConstant: 140),
            tumblrIcon.widthAnchor.constraint(equalToConstant: 130)
            
            
            ].forEach{$0?.isActive = true}
        
        [
            phrase.topAnchor.constraint(equalTo: tumblrIcon.bottomAnchor, constant: 127),
            phrase.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            
            ].forEach{$0.isActive = true}
        
        buttonStackBottomAnchor = buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45)
        loginButtonHeight = loginButton.heightAnchor.constraint(equalToConstant: 40)
        
        [
            
            loginButtonHeight,
            getStarted.heightAnchor.constraint(equalToConstant: 45),
            textField.heightAnchor.constraint(equalToConstant: 45),
            buttonStackBottomAnchor,
            buttonStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            buttonStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            buttonStack.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            
            ].forEach{$0.isActive = true}
        usernameBottomAnchor = self.username.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        [
            usernameBottomAnchor,
            username.centerXAnchor.constraint(equalTo: opacityView.centerXAnchor)
            ].forEach{$0.isActive = true}
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
 
        errorTopAnchor = errorView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: -15)
        [
            errorTopAnchor,
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.heightAnchor.constraint(equalToConstant: 60),
            errorView.widthAnchor.constraint(equalToConstant: 300 )
            ].forEach{$0.isActive = true}
        
    }
    func setUpCredentialStack(){
        let helper = LoginVCHelper()
        emailTextField = helper.emailTextField
        passwordTextField = helper.passwordTextField
        topLoginButton = helper.topLogin
        forgotButton = helper.forgotButton
        cStack = helper.stack
        
        
        view.addSubview(self.topLoginButton!)
        view.addSubview(self.cStack!)
        
        
        cStack?.addArrangedSubview(emailTextField!)
        cStack?.addArrangedSubview(passwordTextField!)
        cStack?.addArrangedSubview(forgotButton!)
        
        topLoginButton?.translatesAutoresizingMaskIntoConstraints = false
        
        [
            topLoginButton!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            topLoginButton!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:   -10)
            ].forEach{$0?.isActive = true }
        
        [
            self.emailTextField?.heightAnchor.constraint(equalToConstant: 35),
            self.passwordTextField?.heightAnchor.constraint(equalToConstant: 35),
            self.forgotButton?.heightAnchor.constraint(equalToConstant: 35),
            cStack?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            cStack?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 40),
            cStack?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            cStack?.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotButton?.leftAnchor.constraint(equalTo: cStack!.leftAnchor)
            ].forEach{$0?.isActive = true}
    }
    func loginButtonAnimated(){
        loginButton.setTitle("Continue", for: .normal)
        loginButton.backgroundColor = UIColor(rgb:0x529ECD)
        loginButtonHeight.constant = 50
        loginButton.isEnabled = true
        loginButton.isUserInteractionEnabled = true
    }
    func loginButtonOriginal(){
        loginButton.setTitle("Log in", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 16)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        loginButtonHeight.constant = 45
        loginButton.isUserInteractionEnabled = true
    }
    func getStartedAnimated(){
        textField.alpha = 1
        getStarted.isHidden = true
    }
    //Buttons
    func addButtonTargets(){
        
        loginButton.addTarget(self, action: #selector(LoginVC.login), for: .touchUpInside)
        backButton.addTarget(nil, action: #selector(LoginVC.dismissKeyboard), for: .touchUpInside)
        getStarted.addTarget(self, action: #selector(LoginVC.signUp), for: .touchUpInside)
    }
    //Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            buttonStackBottomAnchor.constant = -(buttonStack.frame.size.height + keyboardHeight + 50)
            usernameBottomAnchor.constant = -(keyboardHeight + usernameBottomAnchor.constant)
            print(keyboardHeight)
            loginButton.removeTarget(self, action: #selector(LoginVC.login), for: .touchUpInside)
              loginButton.addTarget(self, action: #selector(LoginVC.enterPassword), for: .touchUpInside)
            
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            buttonStackBottomAnchor.constant = -45
            usernameBottomAnchor.constant = -20
            print("hiding")
            loginButton.removeTarget(self, action: #selector(LoginVC.enterPassword), for: .touchUpInside)
            loginButton.addTarget(self, action: #selector(LoginVC.login), for: .touchUpInside)
        }
    }
    func keyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard(){
        if backgroundImage.alpha != 0 {
            returnKeyboard()
            handleDismiss()
            self.errorTopAnchor.constant = -15
            self.errorView.alpha = 0
            
        }else{
            textField.becomeFirstResponder()
            handleDismiss()

        }
    }
    //--End
    
    //Helper
    func returnKeyboard(){
        loginButton.isEnabled = true
        self.view.endEditing(true)
        textField.text = ""
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.tumblrTopAnchor.constant = 80
            self.loginButtonOriginal()
            self.textField.alpha = 0
            self.backgroundImage.alpha = 1
            self.phrase.alpha = 1
            self.backButton.isHidden = true
            self.getStarted.isHidden = false
            self.tumblrIcon.layoutIfNeeded()
            self.backgroundImage.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            self.tumblrIcon.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        }) { (bool) in
            print(true)
        }
    }
    //--End
    
    //Functions
    func handleDismiss(){
        UIView.animate(withDuration: 0.3) {
            self.topLoginButton?.alpha = 0
            self.buttonStack.alpha = 1
            self.cStack?.alpha = 0
            self.emailTextField?.text = ""
            self.passwordTextField?.resignFirstResponder()
            self.passwordTextField?.text = ""
            self.topLoginButton?.isHidden = true
            self.backgroundImage.alpha = 1
            self.buttonStack.alpha = 1
            self.cStack?.alpha = 0
        }
    }
    @objc func enterPassword(){
       
            if textField.text?.isEmpty == true {
                UIView.animate(withDuration: 0.8, delay: 0.3,usingSpringWithDamping: CGFloat(0.20),
                               initialSpringVelocity: CGFloat(6.0), options:.curveEaseIn, animations: {
                                self.errorView.alpha = 1
                                self.errorTopAnchor.constant = 7
                }, completion: { (b) in
                })
            }else{
                self.backgroundImage.alpha = 1
                self.buttonStack.alpha = 0
                self.view.endEditing(true)
                self.textField.resignFirstResponder()
                UIView.animate(withDuration: 0.3) {
                    self.errorTopAnchor.constant = -15
                    self.errorView.alpha = 0
                    self.backgroundImage.alpha = 0
                    self.backButton.alpha = 1
                    self.setUpCredentialStack()
                    self.emailTextField!.text = self.textField.text!
                    self.passwordTextField!.becomeFirstResponder()
                    self.topLoginButton?.alpha = 1
                    self.topLoginButton!.addTarget(self, action: #selector(LoginVC.goToFeed), for: .touchUpInside)
            }
        }
}
    @objc func login(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve, animations: {
            self.textField.becomeFirstResponder()
            self.tumblrTopAnchor.constant = -45
            self.tumblrIcon.layoutIfNeeded()
            self.tumblrIcon.transform = CGAffineTransform.init(scaleX: 0.25, y: 0.25)
            self.backgroundImage.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.phrase.alpha = 0
            self.backButton.isHidden = false
            self.getStartedAnimated()
            self.loginButtonAnimated()
            
            self.buttonStack.layoutIfNeeded()
            
        }) { (bool) in
            print(true)
        }
        print("login")
    }
    @objc func signUp(){
        self.present(signUpVC, animated: false, completion: nil)
        presentingViewController?.modalTransitionStyle = .crossDissolve
    }
    @objc func goToFeed(){
        let feedVC = FeedVC()
        if !emailTextField!.text!.isEmpty && !passwordTextField!.text!.isEmpty{
            AuthService.signIn(email: emailTextField!.text!, password: passwordTextField!.text!, onSuccess: {
                self.present(feedVC, animated: true, completion: nil)
                self.presentingViewController?.modalTransitionStyle = .crossDissolve
            }) { (err) in
                LoginVCHelper.showAlert(message: err!, vc: self)
            }
        }else{
            LoginVCHelper.showAlert(message: "Please fill out all fields", vc: self)
        }
    }
    //--End
    
}
extension LoginVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" && backgroundImage.alpha != 0 {
            enterPassword()
        }else if passwordTextField!.text!.isEmpty == false {
        }
        return true
    }
}
