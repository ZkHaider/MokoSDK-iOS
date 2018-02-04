//
//  Moko.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent

final public class Moko {
    
    // MARK: - Associations
    
    typealias `Self` = Moko
    
    // MARK: - Events
    
    struct Events {
        struct DidFinishBackgroundTask: IdentifiableEvent {}
    }
    
    // MARK: - Attributes
    
    private var hasAlreadyInitializedServices: Bool = false
    private var completionHandler: ((UIBackgroundFetchResult) -> Void)? = nil
    
    // MARK: - Singleton
    
    public static let shared: Moko = Moko()
    private init() {}
    
    // MARK: - Initialization
    
    public static func initialize() {
        shared.initializeServices()
        shared.registerEvents()
    }
    
    fileprivate func registerEvents() {
        
        // This can be refactored and queued up
        if let allServices = 👾.allServices() as? [BaseService] {
            for service in allServices {
                service.add(
                    listener: self,
                    for: Moko.Events.DidFinishBackgroundTask.name,
                    handler: Moko.didFinishBackgroundTask)
            }
        }
    }
    
    fileprivate func initializeServices() {
        if !hasAlreadyInitializedServices {

            // Go ahead and register our services
            👾.register(services: [
                Application.createApplicationService(),
                Permissions.createPermissionsService(),
                Keyboard.createKeyboardService(),
                Social.createSocialService(),
                Sensors.createSensorsService(),
                Telephony.createTelephonyService(),
                Location.createLocationService()
            ])
            
            // Set to true so we don't reinitialize again
            hasAlreadyInitializedServices = true
        }
    }
    
    // Background
    
    public func didFetchBackground(withHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.completionHandler = completionHandler
        NotificationCenter.default.post(name: ApplicationStateService.Notifications.backgroundDidFetch.notifName, object: nil)
    }
    
    fileprivate func didFinishBackgroundTask(_ event: Moko.Events.DidFinishBackgroundTask) {
        
        
        
        // Work finished!
        completionHandler?(.newData)
    }
    
}
