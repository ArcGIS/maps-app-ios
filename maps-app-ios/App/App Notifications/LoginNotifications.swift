//
//  LoginNotifications.swift
//  maps-app-ios
//
//  Created by Nicholas Furness on 4/30/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import ArcGIS

extension MapsAppNotifications.Names {
    static let AppLogin = Notification.Name("MapsAppLoginNotification")
    static let AppLogout = Notification.Name("MapsAppLogoutNotification")
}

extension MapsAppNotifications {
    static func postLoginNotification(user:AGSPortalUser) {
        NotificationCenter.default.post(name: MapsAppNotifications.Names.AppLogin, object: mapsApp,
                                        userInfo: [LoginNotifications.userKey:user])
    }
    
    static func postLogoutNotification() {
        NotificationCenter.default.post(name: MapsAppNotifications.Names.AppLogout, object: mapsApp)
    }
}

extension Notification {
    var loggedInUser:AGSPortalUser? {
        if let user = self.userInfo?[LoginNotifications.userKey] as? AGSPortalUser {
            return user
        }
        return nil
    }
}

fileprivate struct LoginNotifications {
    static let userKey = "user"
}
