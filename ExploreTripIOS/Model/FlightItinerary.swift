//
//  FlightItinerary.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/10/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
import SwiftyJSON

class FlightItinerary{
    var flightLogoURL:String?
    var noOfSeats:Int?
    var validatingCarrierName:String?
    var cityPairs = [CityPair]()
    var fares = [Fares]()
    var totalFare:Double = 0.0
    var totalDuration:Double = 0.0
    var departureDateTime:Date?
    init(dictionary:JSON) {
        if let value = dictionary["FlightLogoURL"].string { self.flightLogoURL = value }
        if let value = dictionary["ValidatingCarrierName"].string { self.validatingCarrierName = value }
        if let value = dictionary["noOfSeats"].int { self.noOfSeats = value }
        if let valuesArray = dictionary["Citypairs"].array {
            for value in valuesArray {
                let newObject = CityPair(dictionary:value)
                self.cityPairs.append(newObject)
                
                //Add for every city pair
                self.totalDuration = self.totalDuration + self.getMinutesFromDuration(newObject.duration ?? "0D 0H 0M")
                 self.departureDateTime = Date.date(from: (self.cityPairs.first?.flightSegmentsArray.first?.departureDateTime)!, format: Constants.utcFormat)
            }
        }
        if let valuesArray = dictionary["Fares"].array {
            for value in valuesArray {
                let newObject = Fares(dictionary:value)
                self.totalFare = self.totalFare + (newObject.travellerBaseFare ?? 0.0)
                self.fares.append(newObject)
            }
        }
    }
    
    func getMinutesFromDuration(_ duration:String) -> Double {
        var totalMinutes:Double = 0.0
        let numberStrings = duration.components(
            separatedBy: NSCharacterSet.decimalDigits.inverted).filter
            { $0.characters.count > 0 }
        
        var days = 0.0
        var hours = 0.0
        var minutes = 0.0
        
        if numberStrings.count == 3 {
            if let value = Double(numberStrings[0]) { days = value }
            if let value = Double(numberStrings[1]) { hours = value }
            if let value = Double(numberStrings[2]) { minutes = value }
        }
        if numberStrings.count == 2 {
            if let value = Double(numberStrings[0]) { hours = value }
            if let value = Double(numberStrings[1]) { minutes = value }
        }
        
        if numberStrings.count == 1 {
            if let value = Double(numberStrings[0]) { minutes = value }
        }
        
        totalMinutes = days*24*60 + hours*60 + minutes
        return totalMinutes
    }
}
