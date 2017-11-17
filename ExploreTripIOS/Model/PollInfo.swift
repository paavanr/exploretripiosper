//
//  File.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/10/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
import SwiftyJSON

class PollInfo {
    var tokenId:String?
    init(dictionary:JSON) {
        if let value = dictionary["TokenId"].string { self.tokenId = value }
    }
}
