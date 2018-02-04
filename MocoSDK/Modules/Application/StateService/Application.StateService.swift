//
//  Application.StateService.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/4/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent

protocol ApplicationStateProvider: Service {}

final class ApplicationStateService: BaseService, ApplicationStateProvider, NotificationObserver {
    
    // MARK: - Attributes
    
    var backgroundOperationQueue: OperationQueue = OperationQueue()
    
    // MARK: - Initialization
    
    required init() {
        super.init()
        
        // Register our queue
//        backgroundOperationQueue.addObserver(self, forKeyPath: #keyPath(OperationQueue.operations), options: .new, context: nil)
        
        for notification in Notifications.all {
            notification.addObserver(self)
        }
    }
    
    // MARK: - Event Handler
    
    func handleNotification(notification: Notification) {
        guard let event = Application.Events.ApplicationEvent(notification: notification) else { return }
        for service in 👾.allServices() {
            service.dispatch(event)
        }
    }
    
}

extension ApplicationStateService {
    
    enum Notifications: String, NotificationName {
        
        case backgroundDidFetch
        
        static let all: [Notifications] = [.backgroundDidFetch]
        
        func addObserver(_ observer: NotificationObserver) {
            NotificationCenter.default.addObserver(observer,
                                                   selector: #selector(NotificationObserver.handleNotification),
                                                   name: self.notifName,
                                                   object: nil)
        }
    }
    
}

extension ServiceCenter {
    
    var applicationStateProvider: ApplicationStateProvider {
        guard let provider = 👾.service(for: ApplicationStateService.defaultIdentifier) as? ApplicationStateProvider else {
            let provider: ApplicationStateProvider = ApplicationStateService()
            return provider
        }
        return provider
    }
    
}
