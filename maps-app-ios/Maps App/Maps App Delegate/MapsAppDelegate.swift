//
//  AppDelegate.swift
//  maps-app-ios
//
//  Created by Nicholas Furness on 3/24/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit

// MARK: Maps App
@UIApplicationMain
class MapsAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: Singleton objects
    internal var appContext = AppContext()
    internal var arcGISServices = ArcGISServices()
    internal var preferences = AppPreferences()
    
}
