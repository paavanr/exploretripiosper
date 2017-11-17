//
//  Location.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/9/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
import SwiftyJSON
class Location{
    var code:String?
    var airportLocation:String?
    init(dictionary:JSON) {
        if let value = dictionary["Code"].string { self.code  = value }
        if let value = dictionary["AirportLocation"].string { self.airportLocation  = value }

    }
}
