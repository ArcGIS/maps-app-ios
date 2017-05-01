//
//  MapsAppDelegate+PortalAutoLogin.swift
//  maps-app-ios
//
//  Created by Nicholas Furness on 4/28/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import ArcGIS

extension MapsAppDelegate {
    func setPortalOnAppStart() {
        // Ensure that credentials are cached in the Keychain.
        AGSAuthenticationManager.shared().credentialCache.enableAutoSyncToKeychain(withIdentifier: "MapsAppiOS", accessGroup: nil, acrossDevices: false)
        
        logInOnAppStartIfPossible()
    }
    
    func logInOnAppStartIfPossible() {
        // Use a custom Portal URL if we've got one saved
        let savedPortalURL = mapsAppPrefs.portalURL
        
        // Find the most logged-in portal we can using cached credentials
        AGSPortal.bestPortalFromCachedCredentials(portalURL: savedPortalURL) { newPortal, didLogIn in
            self.currentPortal = newPortal
        }
    }
}
