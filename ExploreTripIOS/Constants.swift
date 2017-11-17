//
//  Constants.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/10/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import UIKit
struct Constants {
    static let iBeaconCategoryIdentifier = "iBeaconCategoryIdentifier"
    static let iBeaconImmediateProximityActionIdentifier = "iBeaconImmediateProximityActionIdentifier"
    static let iBeaconExitActionIdentifier = "iBeaconExitActionIdentifier"
    static let appColor = "#D52E33"
    static let navColor = "#FDFDFB"
    static let apiToken = "7DF8BB50-674E-4BA1-8F47-E7C1EDC12262"
    //63 129,210
    static let dateFormat = "dd/MM/yyyy"
    static let utcFormat = "yyyy-MM-dd'T'HH:mm:ss"
    static let extactedDateFormat = "EEE - MMM dd"
    static let dateMonthFormat = "MM/dd"
    static let extactedTimeFormat = "hh:mm a"
    static let fullDateFormat = "yyyy-MM-dd hh:mm:ss"
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    enum CoreDataEntities : NSString{
        case Appointment = "Appointment"
        
    }
}
