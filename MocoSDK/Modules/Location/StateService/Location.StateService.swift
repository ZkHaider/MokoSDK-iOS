//
//  Location.StateService.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent
import PassiveDataKit
import CoreLocation

protocol LocationStateProvider: Service {
    var hasRegistered: Bool { get set }
    func registerEventHandlers()
    func unregisterEventHandlers()
}

final class LocationStateService: BaseService, LocationStateProvider, PDKDataListener {
    
    // MARK: - Attributes
    
    var hasRegistered: Bool = false
    
    // MARK: - Initialization
    
    required init() {
        super.init()
        
        add(listener: self,
            for: Location.Events.EnableLocationService.name,
            handler: LocationStateService.enableLocationService)
        
        add(listener: self,
            for: Application.Events.ApplicationEvent.backgroundDidFetch,
            handler: LocationStateService.handleBackgroundFetch)
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse: registerEventHandlers()
        default: break
        }        
    }
    
    // MARK: - Simple Event Handlers
    
    fileprivate func enableLocationService(_ event: Location.Events.EnableLocationService) {
        registerEventHandlers()
    }
    
    fileprivate func handleBackgroundFetch(_ event: Application.Events.ApplicationEvent) {
        Moko.shared.workers = Moko.shared.workers + 1
        
        // do work...
        
        // Let moko know we completed this task
        self.dispatch(Moko.Events.DidFinishBackgroundTask())
    }
    
    // MARK: - Passive Data Kit Handlers
    
    func registerEventHandlers() {
        
        if !hasRegistered {
            
            // Register our pdk location service
            PassiveDataKit.sharedInstance().register(self, for: .location, options: [:])
            
            hasRegistered = true
        }
    }
    
    func unregisterEventHandlers() {
        
        if hasRegistered {
            
            // Unregister our pdk location services
            PassiveDataKit.sharedInstance().unregisterListener(self, for: .location)
            
            hasRegistered = false
        }
    }
    
    func receivedData(_ data: [AnyHashable : Any]!, for dataGenerator: PDKDataGenerator) {
        
    }
    
    func receivedData(_ data: [AnyHashable : Any]!, forCustomGenerator generatorId: String!) {
        print(data)
    }
    
}

extension ServiceCenter {
    
    var locationStateProvider: LocationStateProvider {
        guard let provider = 👾.service(for: LocationStateService.defaultIdentifier) as? LocationStateProvider else {
            let provider: LocationStateProvider = LocationStateService()
            return provider
        }
        return provider
    }
    
}
