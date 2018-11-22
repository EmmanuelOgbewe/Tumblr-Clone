//
//  PostCell.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 10/12/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//

import UIKit
import Nuke

protocol showUsersDelegate : class {
    func clickedUsers (_sender : PostCell)
}
class PostCell: UITableViewCell {
    
    var post : Post? {
        didSet{
            updateView()
        }
    }
    
    let backView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    let userImage : UIImageView = {
        let userImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        userImage.layer.cornerRadius = 2
        userImage.clipsToBounds = true
        userImage.image = UIImage(named: "paulo-silva-575922-unsplash")
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
    let usernameLabel : UILabel = {
        let usernameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        usernameLabel.font = UIFont(name: "Helvetica Neue - Black", size: 16)
        usernameLabel.textColor = UIColor.black
        usernameLabel.text = "eogbewe"
        usernameLabel.contentMode = .left
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        return usernameLabel
    }()
    
    
    let postImage : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100 , height: 200))
        image.image = UIImage(named: "charles-deluvio-693696-unsplash")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var followButton : UIButton = {
      let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
      button.setTitle("Follow", for: .normal)
      button.setTitleColor(UIColor(rgb:0x6A82A9), for: .normal)
      button.titleLabel?.font = UIFont(name: "Helvetica Neue - Black", size: 16)
      button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
      
    }()
    
    var stack : UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let detailsText = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 30))
        let tagsText = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 30))
        detailsText.font = UIFont(name: "Helvetica Neue - Black", size: 16)
        detailsText.numberOfLines = 0
        tagsText.font = UIFont(name: "Helvetica Neue - Black", size: 16)
        tagsText.textColor = UIColor(rgb: 0x9E9FA3)
        detailsText.text = "I will ball to I can't anymore. God has gifted me with a gift and I shall use it untill I die. #ballersLife"
        tagsText.text = "#ballerLife #God #Goals #Success #ambition"
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.addArrangedSubview(detailsText)
        stackView.addArrangedSubview(tagsText)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    var sendButton : UIButton = {
        let sendButton = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
        sendButton.imageEdgeInsets = UIEdgeInsets(top: 4 , left: 4, bottom: 4, right: 4)
        sendButton.imageView?.contentMode = .scaleAspectFit
        sendButton.setImage(UIImage(named: "new_send_button" ), for: .normal)
        sendButton.clipsToBounds = true
        sendButton.isUserInteractionEnabled = true
        return sendButton
    }()
    var commentButton : UIButton = {
        let commentButton = UIButton()
        commentButton.frame.size = CGSize(width: 14, height: 14)
        commentButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.setImage(UIImage(named: "chat-comment-oval-speech-bubble-with-text-lines" ), for: .normal)
        commentButton.clipsToBounds = true
        return commentButton
    }()
    var shareButton : UIButton = {
        let share = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
        share.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        share.setImage(UIImage(named: "replay" ), for: .normal)
        share.clipsToBounds = true
        return share
        
    }()
    var likeButton : UIButton = {
        let heart = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
        heart.imageEdgeInsets = UIEdgeInsets(top: 6, left: 4, bottom: 4, right: 4)
        heart.setImage(UIImage(named: "heart" ), for: .normal)
        heart.clipsToBounds = true
        return heart
    }()
    
    var optionsStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.spacing = 18
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.black.cgColor
        return stackView
    }()
    
     weak var delegate: showUsersDelegate?
    
    func updateView(){
        
        self.backgroundColor = UIColor.init(rgb: 0x36465D)
        self.addSubview(backView)
        backView.addSubview(userImage)
        backView.addSubview(usernameLabel)
        backView.addSubview(followButton)
        backView.addSubview(postImage)
        backView.addSubview(stack)
        backView.addSubview(optionsStack)
        setUpLayout()
        addTargets()
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        //set the values for top,left,bottom,right margins
//        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//        contentView
//    }
    func setUpLayout(){
        
        [
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
            ].forEach{$0.isActive = true}
        
        [
            userImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10 ),
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            userImage.heightAnchor.constraint(equalToConstant: 35),
            userImage.widthAnchor.constraint(equalToConstant: 35)
            ].forEach{$0.isActive = true}
        
        
        [
            usernameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 17),
            usernameLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10)
            
            
            ].forEach{$0.isActive = true}
        
        [
            followButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12),
            followButton.leftAnchor.constraint(equalTo: usernameLabel.rightAnchor, constant: 10)
            
            
            ].forEach{$0.isActive = true}
        
        [
            postImage.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20 ),
            postImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            postImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 200),
            postImage.widthAnchor.constraint(equalToConstant: self.frame.size.width)
            ].forEach{$0.isActive = true}
        
        optionsStack.addArrangedSubview(sendButton)
        optionsStack.addArrangedSubview(commentButton)
        optionsStack.addArrangedSubview(shareButton)
        optionsStack.addArrangedSubview(likeButton)
        
        [
            stack.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 10),
            stack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: self.rightAnchor, constant : 10)
            ].forEach{$0.isActive = true}
        
        optionsStack.layer.borderWidth = 1
        
        [
            optionsStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 5),
            optionsStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant : -15)
            ].forEach{$0.isActive = true}
    }
    func addTargets(){
        sendButton.addTarget(self, action: #selector(PostCell.tappedSendButton), for: .touchUpInside)
    }
    @objc func tappedSendButton(){
        delegate?.clickedUsers(_sender: self)
        print("tapped")
    }
    @objc func tapped(){
        print("hello")
    }
    
    //        guard let thumbImage = post?.photoUrl else {return}
    //        if let url = URL(string: thumbImage), let details = post?.postText, let name = post?.username {
    //            Nuke.loadImage(with:url, into: self.postImage)
    //             guard let time = post?.sentDate.timeAgoDisplay() else {return}
    //
    //            let fullText = "\(details) \n\(name) \(time)"
    //            let stringToColor = "\(name) \(time)"
    //            let range = (fullText as NSString).range(of:stringToColor)
    //            let attribute = NSMutableAttributedString.init(string: fullText)
    //            attribute.addAttributes([NSAttributedString.Key.font : UIFont(name: "Avenir-Roman", size: 13)!, NSAttributedString.Key.foregroundColor : UIColor.gray ], range: range)
    //            self.postDetails.attributedText = attribute
    //        }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
