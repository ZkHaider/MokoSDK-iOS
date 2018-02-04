//
//  Telephony.StateService.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent
import CallKit

protocol TelephonyStateProvider: Service {
    // parameters we need
}

final class TelephonyStateService: BaseService, TelephonyStateProvider {
    
    // MARK: - Attributes
    
    private var hasTelephonyPermissons: Bool = false
    
    // MARK: - Initialziation
    
    required init() {
        super.init()
        
        
        // Add event handlers here
        add(listener: self,
            for: Application.Events.ApplicationEvent.backgroundDidFetch,
            handler: TelephonyStateService.handleBackgroundFetch)
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
    
    var telephonyStateProvider: TelephonyStateProvider {
        guard let provider = 👾.service(for: TelephonyStateService.defaultIdentifier) as? TelephonyStateProvider else {
            let provider: TelephonyStateProvider = TelephonyStateService()
            return provider
        }
        return provider
    }
    
}
