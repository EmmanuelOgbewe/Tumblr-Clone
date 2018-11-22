//
//  FeedVC.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 11/9/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//

import UIKit

class FeedVC: UIViewController, UIGestureRecognizerDelegate,showUsersDelegate {
    //
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(FeedVC.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.white
        
        return refreshControl
    }()
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 450
        tableView.tintColor = UIColor.init(rgb: 0x36465D)
        
        
        return tableView
    }()
    
    let newPostButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.backgroundColor = UIColor(rgb:0x36465D )
        button.addTarget(self, action: #selector(FeedVC.createPost), for: .touchDown)
        button.imageView?.tintColor = UIColor.white
        
        button.setImage(UIImage(named: "convo_addchannel"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let messageBackView : UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(rgb: 0x36465D)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 1
        
        return view
    }()
    
    let usersView : UIView = {
        let feedHelper = FeedVCViewHelper()
        let view = feedHelper.userOptionsView
        view[0].translatesAutoresizingMaskIntoConstraints = false
        
        return view[0]
    }()
    
    // Anchors
    var bottomAnchor : NSLayoutConstraint!
    var popTopAnchor : NSLayoutConstraint!

    override func viewDidLoad(){
        super.viewDidLoad()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUpLayout()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setUpLayout(){
        UIApplication.shared.statusBarStyle = .lightContent
        tableView.backgroundColor = UIColor.init(rgb:0x36465D)
        self.view.addSubview(tableView)
        self.view.addSubview(newPostButton)
        self.view.backgroundColor = UIColor.init(rgb: 0x36465D)
        self.view.tintColor = UIColor.init(rgb: 0x36465D)
        [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
            ].forEach{$0.isActive = true}
        tableView.register(PostCell.self, forCellReuseIdentifier: "postCell")
        tableView.addSubview(self.refreshControl)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        [
            newPostButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant : -50),
            newPostButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15),
            newPostButton.heightAnchor.constraint(equalToConstant: 60),
            newPostButton.widthAnchor.constraint(equalToConstant: 60)
            ].forEach{$0.isActive = true}
        
    }
    func clickedUsers(_sender: PostCell) {
        sendPostToUser()
        print("activated")
    }
    
    @objc func createPost(){
        newPostButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.6, delay: 0,usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0), options: .curveEaseOut, animations: {
                        self.newPostButton.transform = CGAffineTransform.identity
        }) { (bool) in
            print(true)
        }
    }
    @objc func sendPostToUser(){
        view.addSubview(messageBackView)
        messageBackView.addSubview(usersView)
        usersView.frame.size.width = self.view.frame.size.width
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FeedVC.dimissPopUp))
        messageBackView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        newPostButton.isHidden = true
        self.messageBackView.backgroundColor = UIColor(rgb:0x44536A).withAlphaComponent(0.0)
        bottomAnchor =  usersView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -usersView.frame.size.height)
        popTopAnchor = usersView.topAnchor.constraint(equalTo: view.topAnchor, constant: self.view.frame.height - usersView.frame.size.height)
        
        [
            messageBackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageBackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageBackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            messageBackView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ].forEach{$0.isActive = true}
        
        [
            popTopAnchor,
            usersView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            usersView.leftAnchor.constraint(equalTo: view.leftAnchor),
            usersView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomAnchor
            ].forEach{$0.isActive = true}
        print("show")
        
        UIView.animate(withDuration: 0.5) {
            self.messageBackView.backgroundColor = UIColor(rgb:0x44536A).withAlphaComponent(0.8)
            self.tableView.isUserInteractionEnabled = false
            self.messageBackView.isHidden = false
            self.bottomAnchor.constant = (self.popTopAnchor.constant + self.usersView.frame.size.height)
            self.usersView.layoutIfNeeded()
      
        }

            UIView.animate(withDuration: 0.5, animations: {
                self.messageBackView.backgroundColor = UIColor(rgb:0x44536A).withAlphaComponent(0.8)
                self.tableView.isUserInteractionEnabled = false
                self.messageBackView.isHidden = false
                self.bottomAnchor.constant = (self.popTopAnchor.constant + self.usersView.frame.size.height)
                self.usersView.layoutIfNeeded()
            })
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    @objc func dimissPopUp(){
        print("dismiss")
        self.tableView.isUserInteractionEnabled = true
        self.view.endEditing(true)
       
        UIView.animate(withDuration: 0.2) {
            self.messageBackView.backgroundColor = UIColor(rgb:0x44536A).withAlphaComponent(0.0)
            self.messageBackView.isHidden  = true
            self.bottomAnchor.constant = -(self.popTopAnchor.constant + self.usersView.frame.size.height)
            self.usersView.setNeedsLayout()
           
        }
    }
}
extension FeedVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension FeedVC :  UITableViewDelegate, UITableViewDataSource{
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        cell.delegate = self
        cell.updateView()
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

