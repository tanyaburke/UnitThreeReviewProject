//
//  String+Extension.swift
//  UnitThreeReviewProject
//
//  Created by Tanya Burke on 12/17/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation

//handles date for us
extension String {
    //returns an ISO8601DateFormatter
    //international date standard
  static func getISOFormatter() -> ISO8601DateFormatter {
    let isoDateFormatter = ISO8601DateFormatter()
      isoDateFormatter.timeZone = .current
      isoDateFormatter.formatOptions = [
        .withInternetDateTime,
        .withFullDate,
        .withFullTime,
        .withFractionalSeconds, // must have this option
        .withColonSeparatorInTimeZone
      ]
    return isoDateFormatter
  }
  
    //creates a timestamp - creates date and time of the object
  static func getISOTimestamp() -> String { //gets a date object Date()
    let isoDateFormatter = getISOFormatter()
    let timestamp = isoDateFormatter.string(from: Date()) // gets exact/ current date and time
    return timestamp
  }
    
  func convertISODate() -> String {
    let isoDateFormatter = String.getISOFormatter()
    guard let date = isoDateFormatter.date(from: self) else {
      return self
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d yyyy, h:mm a"
    
    let dateString = dateFormatter.string(from: date)
    
    return dateString
  }
  
  func isoStringToDate() -> Date {
    let isoDateFormatter = String.getISOFormatter()
    guard let date = isoDateFormatter.date(from: self) else {
      return Date()
    }
    return date
  }
}
