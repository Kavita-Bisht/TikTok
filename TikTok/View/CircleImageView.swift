//
//  RoundCornerView.swift
//  TikTok
//
//  Created by Ganesh Bisht on 10/08/20.
//  Copyright © 2020 TikTok. All rights reserved.
//


import UIKit

import Foundation
import UIKit


@IBDesignable
class CircleImageView: UIImageView {
    

    override func awakeFromNib() {
        setupView()
    }
    
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}
    



