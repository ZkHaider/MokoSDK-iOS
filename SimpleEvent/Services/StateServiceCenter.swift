//
//  StateServiceCenter.swift
//  SimpleEvent
//
//  Created by Haider Khan on 1/19/18.
//  Copyright © 2018 Koin. All rights reserved.
//

import Foundation

public protocol StateConfiguration {
    func bootstrap(serviceCenter: StateServiceCenter)
}

public struct BlankStateConfiguration: StateConfiguration {
    
    public func bootstrap(serviceCenter: StateServiceCenter) {
        // Blank
    }
}

open class StateServiceCenter: NSObject {
    
    public fileprivate(set) static var serviceQueue: DispatchQueue = {
        let queue = DispatchQueue(
            label: String(describing: StateServiceCenter.self),
            qos: DispatchQoS.userInteractive
        )
        return queue
    }()
    
    public let serviceQueue: DispatchQueue
    
    public static var configuration: StateConfiguration = BlankStateConfiguration()
    
    public let executionThread: ExecutionThread
    
    required public init(context: StateContext = StateContext()) {
        let executionThread = ExecutionThread()
        self.executionThread = executionThread
        self.serviceQueue = StateServiceCenter.serviceQueue
        super.init()
    }
    
    public func bootstrap() {
        serviceQueue.sync { // synchronous
            StateServiceCenter.configuration.bootstrap(serviceCenter: self)
        }
    }
    
}

