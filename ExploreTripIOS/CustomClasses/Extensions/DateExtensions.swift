//
//  DateExtensions.swift
//  truman
//
//  Created by Mashesh Somineni on 9/26/17.
//  Copyright © 2017 Mashesh Somineni. All rights reserved.
//

import Foundation
extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    func toString(dateFormat format: String ) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    static func convertDateFormatter(date: String, currentFormat:String, newFormat:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        let date = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = newFormat
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    static func date(from string:String, format:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: string)
        return date
    }
    static func extractedDate(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.utcFormat
        let newDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = Constants.extactedDateFormat
        let timeStamp = dateFormatter.string(from: newDate!)
        return timeStamp
    }

    static func extractedTime(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.utcFormat
        let newDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = Constants.extactedTimeFormat
        let timeStamp = dateFormatter.string(from: newDate!)
        return timeStamp
    }
    // if you omit last parameter you comare with today
    // use "11/20/2016" for 20 nov 201
}
