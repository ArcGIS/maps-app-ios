//
//  MapViewMode.swift
//  maps-app-ios
//
//  Created by Nicholas Furness on 3/31/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import ArcGIS

enum MapViewMode: CustomStringConvertible {
    case none
    case search
    case routeResult(AGSRoute)
    case geocodeResult(AGSGeocodeResult)
    
    var description: String {
        switch self {
        case .none:
            return "none"
        case .search:
            return "Search"
        case .routeResult:
            return "RouteResult"
        case .geocodeResult:
            return "GeocodeResult"
        }
    }
    
    var humanReadableDescription: String {
        switch self {
        case .geocodeResult(let result):
            return "Geocode \"\(result.label)\""
        case .routeResult(let route):
            return "Route \(route.routeName)".replacingOccurrences(of: " - ", with: " to ")
        default:
            return "\(self)"
        }
    }
}
