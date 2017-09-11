//
//  AppSettings.swift
//  maps-app-ios
//
//  Created by Nicholas Furness on 4/28/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import Foundation

struct AppSettings {
    private static let agsSettings:[String:Any] = (Bundle.main.infoDictionary?["AppConfiguration"] as? [String:Any]) ?? [:]
    private static func getAgsSetting<T>(named name:String) -> T? {
        return (agsSettings[name] as? T)
    }

    private static let authSettings:[String:Any]? = getAgsSetting(named: "PortalAuthConfig")

    
    // MARK: Runtime Licensing
    // Set up AGSLicenseKey in the project's info.plist to remove the Developer watermark.
    // See https://developers.arcgis.com/ios/latest/swift/guide/license-your-app.htm#ESRI_SECTION1_25AC0000E35A4E52B713E8D50359A75C
    static let licenseKey = getAgsSetting(named: "LicenseKey") ?? ""



    // MARK: Portal Auth Config
    // If there is a PortalURL setting in the info.plist file, then use that, otherwise leave it blank and the
    // app will fall back to ArcGIS Online.
    static let portalURL:URL? = {
        if let urlString = authSettings?["PortalURL"] as? String, let url = URL(string: urlString) {
            return url
        }
        return nil
    }()

    // Set up AppClientID in the project's info.plist. This is used for the OAuth panel and will determine what app users see
    // when they log in to authorize the app to view their account and use their routing/geocoding tasks. A ClientID is specific
    // to a particular portal (and is derived from an Application created within that portal).
    static let clientID = authSettings?["ClientID"] as? String ?? ""


    // MARK: Runtime OAuth Configuration
    // appScheme and authURLPath are used to tell OAuth how to call back to this app.
    // For example, if they're set up as follows:
    //    AppURLSchema   = "maps-app-ios"
    //    AuthURLPath = "auth"
    // Then the app should register "maps-app-ios" as a URL Type's scheme. And OAuth will call back to maps-app-ios://auth.
    //
    // See also MapsAppDelegate+PortalOAuth.swift
    static let appSchema = getAgsSetting(named: "AppURLScheme") ?? ""
    static let authURLPath = getAgsSetting(named: "AuthURLPath") ?? ""
    

    // MARK: Runtime Keychain Integration
    static let keychainIdentifier = getAgsSetting(named: "KeychainIdentifier") ?? ""


    // MARK: Portal Basemap Group Querying
    // How many basemaps to get back in a single group items query.
    // Can help to avoid loading multiple pages of results.
    static let basemapPageQuerySize:Int = getAgsSetting(named: "BasemapQueryPageSize") ?? 10
    

    // MARK: Default Services
    // Default fallback URLs for routing and geocoding services if a portal config cannot be read.
    static let worldRoutingServiceURL = URL(string: getAgsSetting(named: "DefaultRouteServiceURL") ?? "")!
    static let worldGeocoderURL = URL(string: getAgsSetting(named: "DefaultGeocodeServiceURL") ?? "")!


    // MARK: User Preferences
    // Determine where user preferences are stored
    static let preferencesStore = UserDefaults.standard
}
