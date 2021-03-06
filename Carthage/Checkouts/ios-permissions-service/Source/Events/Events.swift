//
//  CalendarEvent.swift
//
//  Created by Les Melnychuk on 2/19/16.
//  Copyright © 2016 LembergSolutions. All rights reserved.
//

#if PERMISSION_EVENTS
import UIKit
import EventKit

public final class Events: PermissionService {
    
    public required init(with configuration: PermissionConfiguration) { }

    let type = EKEntityType.event
        
    public func requestPermission(_ requestGranted: @escaping (_ successRequestResult: Bool) -> Void) {
        
        EKEventStore().requestAccess(to: type) {
            (accessGranted: Bool, error: Error?) in
            requestGranted(accessGranted)
        }
    }
    
    public func status() -> PermissionStatus {
        let status = EKEventStore.authorizationStatus(for: type)
        return status.rawValue.permissionStatus()
    }
    
    
}
    
#endif
