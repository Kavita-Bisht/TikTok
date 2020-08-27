//
//  UIViewController+Extension.swift
//  TikTok
//
//  Created by Ganesh Bisht on 10/08/20.
//  Copyright © 2020 TikTok. All rights reserved.
//


import Foundation
import UIKit



extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

}
