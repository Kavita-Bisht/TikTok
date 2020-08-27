//
//  RoundCornerButton.swift
//  TikTok
//
//  Created by Ganesh Bisht on 10/08/20.
//  Copyright © 2020 TikTok. All rights reserved.
//


import UIKit


@IBDesignable
class RoundCornerButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
    
   

}
