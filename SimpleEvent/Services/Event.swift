//
//  Event.swift
//  SimpleEvent
//
//  Created by Haider Khan on 1/18/18.
//  Copyright © 2018 Koin. All rights reserved.
//

import Foundation

public protocol Event {
    var type: EventType { get }
}

public protocol EventType {
    var name: String { get }
}

extension Notification.Name: EventType {
    public var name: String {
        return rawValue
    }
}

extension String: Event, EventType {
    public var type: EventType { return self }
    public var name: String {
        return self
    }
}

public protocol IdentifiableEvent: Event, EventType {}

public extension IdentifiableEvent {
    
    public var type: EventType { return self }
    public var name: String {
        return String(reflecting: self).components(separatedBy: "(")[0]
    }
    
    public static var name: String {
        return String(reflecting: self).components(separatedBy: "(")[0]
    }
    
}
