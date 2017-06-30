//
//  MapsAppDelegate+PortalOAuth.swift
//  maps-app-ios
//
//  Created by Nicholas Furness on 4/28/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit
import ArcGIS

extension MapsAppDelegate {
    func handlePortalAuthOpenURL(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // Handle OAuth callback from application(app,url,options) when the app's URL schema is called. See AppSettings.swift
        if let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            urlComponents.scheme == AppSettings.appSchema, urlComponents.host == AppSettings.authURLPath {
            
            AGSApplicationDelegate.shared().application(app, open: url, options: options)
            
            // See if we were called back with confirmation that we're authorized.
            if let _ = urlComponents.queryParameter(named: "code") {
                // If we were authenticated, there should now be a shared credential to use. Let's try it.
                logInCurrentPortalIfPossible()
            }
            
        }
        return true
    }
    
    func logInCurrentPortalIfPossible() {
        // Try to take the current portal and update it to be in a logged in state.
        mapsAppState.currentPortal?.load() { error in
            guard error == nil else {
                return
            }
            
            // Only try logging in if the current portal isn't logged in (user == nil)
            // That is, we got here because the AuthenticationManager is being called back from some  in-line OAuth
            // success based off a call to a service (an explicit login would set portal.user != nil).
            if let portal = mapsAppState.currentPortal, let portalURL = portal.url, portal.user == nil {
                AGSPortal.bestPortalFromCachedCredentials(portalURL: portalURL) { newPortalInstance, didLogIn in
                    if didLogIn {
                        // Finally update the current portal if we managed to log in.
                        mapsAppState.currentPortal = newPortalInstance
                    }
                }
            }
        }
    }
}

