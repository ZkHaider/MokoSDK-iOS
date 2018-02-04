//
//  Telephony.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation

struct Telephony {
    
    static func createTelephonyService() -> TelephonyStateService {
        return TelephonyStateService() 
    }
    
}

extension Telephony {
    
    struct Events {
        
    }
    
}
