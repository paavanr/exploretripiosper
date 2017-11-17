//
//  Fares.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/30/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
import SwiftyJSON

class Fares{
    var currencyCode:String?
    var baseFare:String?
    var travellerBaseFare:Double?
    var travellerTaxes:Double?

    init(dictionary:JSON) {
        if let value = dictionary["CurrencyCode"].string { self.currencyCode  = value }
        if let value = dictionary["BaseFare"].string { self.baseFare  = value }
        if let value = dictionary["TravellerBaseFare"].double { self.travellerBaseFare  = value }
        if let value = dictionary["TravellerTaxes"].double { self.travellerTaxes  = value }

     }
}
