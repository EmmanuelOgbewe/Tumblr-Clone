//
//  FeedVCViewHelper.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 11/12/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//
// This class is a helper class for the FeedVC. It contains some components needed
// in that class

import UIKit
class FeedVCViewHelper {
    
    let userOptionsView : [UIView] = {
        //
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 250))
        let messageLabel = UITextField()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        //
        view.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //
        messageLabel.placeholder = "Message to..."
        collectionView.backgroundColor = UIColor.white
        //
        view.backgroundColor = UIColor.white
        view.addSubview(messageLabel)
        view.addSubview(collectionView)
        //
        [
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant : 15),
            messageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
            ].forEach{$0.isActive = true}
        
        [
             collectionView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
            ].forEach{$0.isActive = true}
        
        return [view, collectionView]
        
    }()
    
    

}
