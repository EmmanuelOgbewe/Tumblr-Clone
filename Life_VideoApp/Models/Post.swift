//
//  Post.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 10/11/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Post {
    
    let id: String?
    let username: String
    let senderId : String
    let videoUrl : String
    let photoUrl : String
    let postText : String
    let sentDate: Date
    
    init(username: String, videoUrl: String, photoUrl: String, postText: String, senderId: String) {
        id = nil
        self.username = username
        self.videoUrl = videoUrl
        self.photoUrl = photoUrl
        self.postText = postText
        self.senderId = senderId
        sentDate = Date()
        
    }
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let username = data["username"] as? String else {
            return nil
        }
        guard let videoUrl = data["videoUrl"] as? String else{
            return nil
        }
        guard let photoUrl = data["photoUrl"] as? String else {
            return nil
        }
        guard let postText = data["postText"] as? String else {
            return nil
        }
        guard let sentDate = data["created"] as? Date else {
            return nil
        }
        guard let senderId = data["senderId"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.username = username
        self.videoUrl = videoUrl
        self.photoUrl = photoUrl
        self.sentDate = sentDate
        self.postText = postText
        self.senderId = senderId
        
    }
}

extension Post: DataRepresentation {
    var representation: [String : Any] {
        var rep: [String : Any] = ["username": username, "videoUrl": videoUrl, "photoUrl": photoUrl, "created": sentDate, "postText": postText, "senderId": senderId]
        
        if let id = id {
            rep["id"] = id
        }
        
        return rep
    }
}

extension Post: Comparable {
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Post, rhs: Post) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
}


