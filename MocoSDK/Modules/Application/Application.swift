//
//  Application.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/4/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent

struct Application {
    
    static func createApplicationService() -> ApplicationStateService {
        return ApplicationStateService()
    }
    
}

extension Application {
    
    struct Events {
        struct DidFinishBackgroundTask: IdentifiableEvent {}
        struct RunBackgroundTask: IdentifiableEvent {}
        enum ApplicationEvent: IdentifiableEvent {
            
            case backgroundDidFetch
            
            public var type: EventType {
                return String(reflecting: self).components(separatedBy: "(")[0]
            }
            
            public var notificationName: NotificationName {
                switch self {
                case .backgroundDidFetch:
                    return ApplicationStateService.Notifications.backgroundDidFetch
                }
            }
            
            init?(notification: Notification) {
                switch notification.name {
                case ApplicationStateService.Notifications.backgroundDidFetch.notifName: self = .backgroundDidFetch
                default: self = .backgroundDidFetch
                }
            }
        }
    }
    
}
