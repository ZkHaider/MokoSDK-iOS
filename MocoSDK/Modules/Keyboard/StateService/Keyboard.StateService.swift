//
//  Keyboard.StateService.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent

protocol KeyboardStateProvider: Service {
    // TODO
}

final class KeyboardStateService: BaseService, KeyboardStateProvider {
    
    // MARK: - Attribtues
    
    
    
    // MARK: - Initialization
    
    required init() {
        super.init()
        
        // Add event handlers here
        add(listener: self,
            for: Application.Events.ApplicationEvent.backgroundDidFetch,
            handler: KeyboardStateService.handleBackgroundFetch)
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
    
    var keyboardStateProvider: KeyboardStateProvider {
        guard let provider = 👾.service(for: KeyboardStateService.defaultIdentifier) as? KeyboardStateProvider else {
            let provider: KeyboardStateProvider = KeyboardStateService()
            return provider
        }
        return provider
    }
    
}
