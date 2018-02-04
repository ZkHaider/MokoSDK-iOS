//
//  Weak.swift
//  SimpleEvent
//
//  Created by Haider Khan on 1/27/18.
//  Copyright © 2018 Koin. All rights reserved.
//

import Foundation

public class Weak<T: AnyObject> {
    
    weak var value: T?
    
    public init(value: T) {
        self.value = value
    }
    
}
