//
//  InteractionUtil.swift
//  TikTok
//
//  Created by Ganesh Bisht on 10/08/20.
//  Copyright © 2020 TikTok. All rights reserved.
//


import Foundation
import UIKit

struct InteractionUtil {
    
    static func pauseUserInteraction() {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    static func resumeUserInteraction() {
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
