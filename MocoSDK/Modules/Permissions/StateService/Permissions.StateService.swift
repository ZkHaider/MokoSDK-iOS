//
//  Permissions.StateService.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation
import SimpleEvent
import PermissionsService

protocol PermissionsStateProvider: Service {}

final class PermissionsStateService: BaseService, PermissionsStateProvider, Permissible {
    
    internal struct Messages: ServiceMessages {
        var restrictedMessage: String {
            return "This permission is restricted here"
        }
        var restrictedTitle: String {
            return "Service Restricted"
        }
        
        var deniedMessage: String {
            return ""
        }
        
        var deniedTitle: String {
            return ""
        }
    }
    
    required init() {
        super.init()
        
        // Register background service
        add(listener: self,
            for: Application.Events.ApplicationEvent.backgroundDidFetch,
            handler: PermissionsStateService.handleBackgroundFetch)
        
        // Add permissions handlers
        addLocationPermissions()
        addCameraPermissions()
        // Continue adding permissions here...
    }
    
    // MARK: - Handle Background Fetch
    
    fileprivate func handleBackgroundFetch(_ event: Application.Events.ApplicationEvent) {
        Moko.shared.workers = Moko.shared.workers + 1

        // do work...
        
        // Let moko know we completed this task
        self.dispatch(Moko.Events.DidFinishBackgroundTask())
    }
    
    // MARK: - Permissions
    
    func showAlert(vc: UIAlertController) {
        
    }
    
    fileprivate func addLocationPermissions() {
        
        let alwaysConfig = LocationConfiguration(.always, with: Messages())
        let whenInUseConfig = LocationConfiguration(.whenInUse, with: Messages())
        
        Permission<PermissionsService.Location>.prepare(for: self, with: alwaysConfig) { granted in
            
            // Send off event to register our location service
            let location: LocationStateProvider = 👾.locationStateProvider
            location.dispatch(Location.Events.EnableLocationService())
        }
        
        Permission<PermissionsService.Location>.prepare(for: self, with: whenInUseConfig) { granted in
            
            // Send off event to register our location service
            let location: LocationStateProvider = 👾.locationStateProvider
            location.dispatch(Location.Events.EnableLocationService())
        }
    }
    
    fileprivate func addCameraPermissions() {
        
        let cameraConfig = DefaultConfiguration(with: Messages())
        
        Permission<PermissionsService.Camera>.prepare(for: self, with: cameraConfig) { granted in
            
            // Send off event to register our camera service
        }
    }
    
}

extension ServiceCenter {
    
    var permissionStateProvider: PermissionsStateProvider {
        guard let provider = 👾.service(for: PermissionsStateService.defaultIdentifier) as? PermissionsStateProvider else {
            let provider: PermissionsStateProvider = PermissionsStateService()
            return provider
        }
        return provider
    }
    
}
