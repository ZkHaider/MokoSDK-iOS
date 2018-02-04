//
//  Service.swift
//  SimpleEvent
//
//  Created by Haider Khan on 1/18/18.
//  Copyright © 2018 Koin. All rights reserved.
//

import Foundation

public typealias ServiceIdentifier = String

public protocol Service {
    init()
    var identifier: ServiceIdentifier { get }
    func dispatch(_ event: IdentifiableEvent)
}

extension Service {
    public static var defaultIdentifier: ServiceIdentifier {
        return ServiceIdentifier(reflecting: self)
    }
}

open class BaseService: Service {
    
    public var identifier: String {
        get { return ServiceIdentifier(reflecting: self) }
    }

    var eventMap: [String: ActionPerformer] = [String: ActionPerformer]()
    
    public required init() {}
    
    public func add<L: AnyObject, E: IdentifiableEvent>(
        listener: L,
        for eventType: EventType,
        handler: @escaping ((L) -> (E) -> ())
        ) {
        let key = eventType.name
        let actionEvent = TargetActionEventWrapper<L, E>(target: listener, action: handler)
        eventMap[key] = actionEvent
    }
    
    public func dispatch(_ event: IdentifiableEvent) {
        let key = event.type.name
        guard let actionEvent = eventMap[key] else { return }
        actionEvent.tryAction(event: event)
    }
    
}
