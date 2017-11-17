//
//  File.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/10/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
import SwiftyJSON

class CityPair {
    var sector:String?
    var duration:String?
    var flightSegmentsArray = [FlightSegment]()
    init(dictionary:JSON) {
        if let value = dictionary["sector"].string { self.sector  = value }
        if let value = dictionary["Duration"].string { self.duration  = value }
        if let array = dictionary["FlightSegment"].array {
            for value in array{
                let newObject = FlightSegment(dictionary: value)
                self.flightSegmentsArray.append(newObject)
            }
        }
    }
}
