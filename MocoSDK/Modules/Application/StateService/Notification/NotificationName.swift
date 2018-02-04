//
//  NotificationName.swift
//  MocoSDK
//
//  Created by Haider Khan on 2/4/18.
//  Copyright © 2018 moco. All rights reserved.
//

import Foundation

protocol NotificationName {
    var notifName: Notification.Name { get }
}

extension NotificationName where Self: RawRepresentable, Self.RawValue == String {
    var notifName: Notification.Name {
        get { return Notification.Name(self.rawValue) }
    }
}

@objc protocol NotificationObserver {
    func handleNotification(notification: Notification)
}
