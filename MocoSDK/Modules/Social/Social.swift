//
//  Social.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent

struct Social {
    
    static func createSocialService() -> SocialStateService {
        return SocialStateService()
    }
    
}

extension Social {
    
    struct Events {
        
    }
    
}
