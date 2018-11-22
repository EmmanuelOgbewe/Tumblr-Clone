//
//  TextViewHelper.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 11/10/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//
// This class is a helper class for using a textView in any class. 

import UIKit

class TextViewHelper: UITextView, UITextViewDelegate {
    
    public static func drawView(viewController: UIViewController) -> UITextView{
        let text = UITextView(frame:  CGRect(x: 0, y: 0, width: 200, height: 100))
        text.backgroundColor = UIColor.lightGray
        viewController.view.addSubview(text)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        [
            text.topAnchor.constraint(equalTo:viewController.view.safeAreaLayoutGuide.topAnchor),
            text.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            text.heightAnchor.constraint(equalToConstant: 50)
            
            ].forEach{$0.isActive = true}
        self.textViewDidChange(text,view: viewController.view)
        text.font = UIFont.preferredFont(forTextStyle: .headline)
        text.isScrollEnabled = false
        return text
    }

    public static func textViewDidChange(_ textView: UITextView, view: UIView) {
        print(true)
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    

}
