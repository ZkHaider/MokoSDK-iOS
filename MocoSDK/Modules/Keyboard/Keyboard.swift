//
//  Keyboard.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent

struct Keyboard {
    
    static func createKeyboardService() -> KeyboardStateService {
        return KeyboardStateService()
    }
    
}

extension Keyboard {
    
    struct Events {
        
    }
    
}
