//
//  User.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 11/15/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
import SwiftyJSON
class User{
    var hasSaleAviator:Bool?
    var requestForAviator:Bool?
    var isActive:Bool?
    var approved:Bool?
    var ctUserTypeId:Int?
    var countryPhoneExtension:String?
    var cypherKey:String?
    var isAgent:Bool?
    var userId:String?
    var totalActivitesCount:String?
    var status:[String:Any]?
    var createdDateTime:Int?
    var isEmailVerified:Bool?
    var flightBookingsCount:Int?
    var isInternal:Bool?
    var isApproved:Bool?
    
    init(dictionary:JSON) {
        if let value = dictionary["HasSaleAviator"].bool { self.hasSaleAviator  = value }
        if let value = dictionary["requestForAviator"].bool { self.requestForAviator  = value }
        if let value = dictionary["IsActive"].bool { self.isActive  = value }
        if let value = dictionary["approved"].bool { self.approved  = value }
        if let value = dictionary["CtUserTypeId"].int { self.ctUserTypeId  = value }
        if let value = dictionary["countryPhoneExtension"].string { self.countryPhoneExtension  = value }
        if let value = dictionary["cypherKey"].string { self.cypherKey  = value }
        if let value = dictionary["IsAgent"].bool { self.isAgent  = value }
        if let value = dictionary["userId"].string { self.userId  = value }
        if let value = dictionary["Status"].dictionaryObject { self.status  = value }
        if let value = dictionary["CreatedDateTime"].int { self.createdDateTime  = value }
        if let value = dictionary["IsEmailVerified"].bool { self.isEmailVerified  = value }
        if let value = dictionary["FlightBookingsCount"].int { self.flightBookingsCount  = value }
        if let value = dictionary["IsInternal"].bool { self.isInternal  = value }
        if let value = dictionary["IsApproved"].bool { self.isApproved  = value }
    }
}
