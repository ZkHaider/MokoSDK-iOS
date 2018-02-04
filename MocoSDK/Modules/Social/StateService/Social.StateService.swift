//
//  Social.StateService.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent

protocol SocialStateProvider: Service {
    // TODO..
}

final class SocialStateService: BaseService, SocialStateProvider {
    
    // MARK: - Attributes
    
    // ...
    
    // MARK: - Initialization
    
    required init() {
        super.init()
        
        // Add event handlers
        add(listener: self,
            for: Application.Events.ApplicationEvent.backgroundDidFetch,
            handler: SocialStateService.handleBackgroundFetch)
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
    
    var socialStateProvider: SocialStateProvider {
        guard let provider = 👾.service(for: SocialStateService.defaultIdentifier) as? SocialStateProvider else {
            let provider: SocialStateProvider = SocialStateService()
            return provider
        }
        return provider
    }
    
}
