//
//  Sensors.StateService.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent
import CoreMotion

protocol SensorsStateProvider: Service {
    // TODO...
}

final class SensorsStateService: BaseService, SensorsStateProvider {
    
    // MARK: - Attributes
    
    private var hasSensorPermissions: Bool = false 
    
    // MARK: - Initialization
    
    required init() {
        super.init()
        
        add(listener: self,
            for: Application.Events.ApplicationEvent.backgroundDidFetch,
            handler: SensorsStateService.handleBackgroundFetch)
    }
    
    // MARK: - Event Handlers
    
    fileprivate func handleBackgroundFetch(_ event: Application.Events.ApplicationEvent) {
        Moko.shared.workers = Moko.shared.workers + 1

        // do work...
        
        // Let moko know we completed this task
        self.dispatch(Moko.Events.DidFinishBackgroundTask())
    }
    
}

extension ServiceCenter {
    
    var sensorStateProvider: SensorsStateProvider {
        guard let provider = 👾.service(for: SensorsStateService.defaultIdentifier) as? SensorsStateProvider else {
            let provider: SensorsStateProvider = SensorsStateService()
            return provider
        }
        return provider
    }
    
}
