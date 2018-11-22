//
//  HelperService.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 10/11/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class HelperService {
    
    static func uploadDataToServer(data: Data? = nil, videoUrl: URL? = nil, username : String, senderId : String, postText : String, onSuccess: @escaping () -> Void) {
        if let data = data {
            if let videoUrl = videoUrl{
                print("video url exists:",videoUrl)
                self.uploadVideoToFirebaseStorage(videoUrl: videoUrl, onSuccess: { (videoUrl) in
                     print("trying to upload video")
                    uploadImageToFirebaseStorage(data: data, onSuccess: { (thumbnailImageUrl) in
                
                        sendPostToDatabase(photoUrl: thumbnailImageUrl, videoUrl: videoUrl, username: username,senderId : senderId, postText: postText,  onSuccess: onSuccess)
                    })
                })
            } else {
                uploadImageToFirebaseStorage(data: data) { (photoUrl) in
                    self.sendPostToDatabase(photoUrl: photoUrl, username: username, senderId: senderId,postText : postText, onSuccess: onSuccess)
                }
            }
        }
    }
    
    static func uploadVideoToFirebaseStorage(videoUrl: URL, onSuccess: @escaping (_ videoUrl: String) -> Void) {
        let videoIdString = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("posts").child(videoIdString)
        storageRef.putFile(from: videoUrl, metadata: nil) { (metadata, error) in
            print("done")
            if error != nil {
                return
            }
                storageRef.downloadURL(completion: { (url, err) in
                    if err == nil{
                        guard let vidUrl = url?.absoluteString else{return }
                        onSuccess(vidUrl)
                    }else{
                        print(err!.localizedDescription)
                        return
                    }
                })
            
        }
    }
    
    static func uploadImageToFirebaseStorage(data: Data, onSuccess: @escaping (_ imageUrl: String) -> Void) {
        let photoIdString = NSUUID().uuidString
        let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("posts").child(photoIdString)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.putData(data, metadata: metaData) { (metadata, error) in
            if error != nil {
                //                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            storageRef.downloadURL(completion: { (url, err) in
                if err == nil{
                    guard let vidUrl = url?.absoluteString else{return }
                    onSuccess(vidUrl)
                }else{
                    print(err!.localizedDescription)
                    return
                }
            })
        }
    }
    
    static func sendPostToDatabase(photoUrl: String, videoUrl: String? = nil, username : String , senderId: String, postText : String,onSuccess: @escaping () -> Void) {
        
        let db = Firestore.firestore()
        let postRef = db.collection("posts").document()
        
        var dict = ["username" : username, "photoUrl": photoUrl, "postText": postText, "created" : Date(), "senderId" : senderId] as [String : Any]
        if let videoUrl = videoUrl {
            dict["videoUrl"] = videoUrl
        }
        postRef.setData(dict) { (err) in
            if err != nil {
                print(err!.localizedDescription)
            }else{
                onSuccess()
            }
        }
    }
}


