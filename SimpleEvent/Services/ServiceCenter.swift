//
//  ServiceCenter.swift
//  SimpleEvent
//
//  Created by Haider Khan on 1/27/18.
//  Copyright © 2018 Koin. All rights reserved.
//

import Foundation

@nonobjc
public var 👾: ServiceCenter {
    return ServiceCenter.default
}

open class ServiceCenter: NSObject {
    
    // MARK: - Attributes
    
    internal var activeServices: [ServiceIdentifier: Service] = [:]
    
    // MARK: - Initializers
    
    public static let `default`: ServiceCenter = ServiceCenter()
    
    // MARK: - Registration Functions
    
    public func register<T: Service>(services: [T]) {
        for service in services {
            let identifier = service.identifier
            activeServices[identifier] = service
        }
    }
    
    public func register<T: Service>(service: T) {
        let identifier = service.identifier
        activeServices[identifier] = service
    }
    
    public func unregister(with identifier: ServiceIdentifier) {
        activeServices[identifier] = nil
    }
    
    public func service<T>(for identifier: ServiceIdentifier) -> T? where T: BaseService {
        return activeServices[identifier] as? T ?? nil
    }
    
    public func anyService(for identifier: ServiceIdentifier) -> Service? {
        return activeServices[identifier]
    }
    
    public func retrieveService<T>() -> T where T: BaseService {
        let identifier = T.defaultIdentifier
        guard let service: T = self.service(for: identifier) else {
            let service = T()
            register(service: service)
            return service
        }
        return service
    }
    
    public func allServices() -> [Service] {
        return activeServices.values.flatMap({$0})
    }
    
}
