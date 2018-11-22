//
//  AuthService.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 11/20/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

public class AuthService {
    
    //Signup user
    static private let db = Firestore.firestore()
    
    static func signUp (username: String, password: String, email:String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if(err != nil){
                onError(err!.localizedDescription)
            }
            guard let user = result?.user else { return }
            print(user.uid)
            AuthService.setUserInfo(uid: user.uid, username: username.lowercased(), password: password, email: email, onSuccess: {
                onSuccess()
            })
        }
    
    }
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        })
    }
    static func logout(onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        do {
            try Auth.auth().signOut()
            onSuccess()
            
        } catch let logoutError {
            onError(logoutError.localizedDescription)
        }
    }
    static func setUserInfo(uid: String, username: String, password: String, email:String, onSuccess: @escaping () -> Void){
        print("running")
        let data : [String: Any] = ["id": uid, "username": username, "email": email]
        db.collection("users").document(uid).setData(data, completion: { (err) in
            if(err != nil){
                print(err!.localizedDescription)
                return
            }
            onSuccess()
        })
    }
    static func checkEmail (email:String, onSuccess: @escaping (Bool) -> Void){
        db.collection("users").whereField("email", isEqualTo: email)
            .getDocuments() { (querySnapshot, err) in
                print("running")
                if let err = err {
                    print("Error getting documents: \(err)")
                    onSuccess(false)
                    
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        if document.exists == true{
                            onSuccess(true)
                        }
                    }
                    onSuccess(false)
                    
                }
        }
    }
}
