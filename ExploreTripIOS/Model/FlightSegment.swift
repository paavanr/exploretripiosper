//
//  FlightItenary.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/10/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
import SwiftyJSON

class FlightSegment{
    var displayName:String?
    var marketingAirline:String?
    var arrivalLocationCode:String?
    var flightNumber:Int?
    var departureLocationCode:String?
    var noOfStops:Int?
    var flightLogoURL:String?
    var operatingAirline:String?
    var cabinClass:String?
    var marketingAirlineName:String?
    var operatingAirlineName:String?
    var arrivalDateTime:String?
    var airEquipmentType:String?
    var departureDateTime:String?
    var duration:String?
    var flightLogoName:String?
    var bookingClass:String?
    var departureDisplayName:String?

    init(dictionary:JSON) {
        if let value = dictionary["DisplayName"].string { self.displayName  = value }
        if let value = dictionary["MarketingAirline"].string { self.marketingAirline  = value }
        if let value = dictionary["ArrivalLocationCode"].string { self.arrivalLocationCode  = value }
        if let value = dictionary["FlightNumber"].int { self.flightNumber  = value }
        if let value = dictionary["DepartureLocationCode"].string { self.departureLocationCode  = value }
        if let value = dictionary["NoOfStops"].int { self.noOfStops  = value }
        if let value = dictionary["FlightLogoURL"].string { self.flightLogoURL  = value }
        if let value = dictionary["OperatingAirline"].string { self.operatingAirline  = value }
        if let value = dictionary["OperatingAirlineName"].string { self.operatingAirlineName  = value }
        if let value = dictionary["CabinClass"].string { self.cabinClass  = value }
        if let value = dictionary["MarketingAirlineName"].string { self.marketingAirlineName  = value }
        if let value = dictionary["ArrivalDateTime"].string { self.arrivalDateTime  = value }
        if let value = dictionary["AirEquipmentType"].string { self.airEquipmentType  = value }
        if let value = dictionary["DepartureDateTime"].string { self.departureDateTime  = value }
        if let value = dictionary["Duration"].string { self.duration  = value }
        if let value = dictionary["FlightLogoName"].string { self.flightLogoName  = value }
        if let value = dictionary["BookingClass"].string { self.bookingClass  = value }
        if let value = dictionary["DepartureDisplayName"].string { self.departureDisplayName  = value }
    }
}

