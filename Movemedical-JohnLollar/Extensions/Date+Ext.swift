//
//  Date+Ext.swift
//  Movemedical-JohnLollar
//
//  Created by John Lollar on 11/6/22.
//

import Foundation

extension Date {
    static var madeupDate: Date {
        get {
            var dateComponents = DateComponents()
            let minutes = [0, 15, 30, 45]
            
            dateComponents.year = 2022
            dateComponents.month = 11
            dateComponents.day = Int.random(in: 14...18)
            dateComponents.timeZone = TimeZone(abbreviation: "CST")
            dateComponents.hour = Int.random(in: 9...17)
            dateComponents.minute = minutes.randomElement()
            
            let calendar = Calendar(identifier: .gregorian)
            
            guard let date = calendar.date(from: dateComponents) else { return Date.now }
            
            return date
        }
    }
    
    static var toInterval: Date {
        get {
            let date = Date.now
            let calendar = Calendar.current
            
            let minute = calendar.component(.minute, from: date)
            
            var minutesToAdd = 0
            var secondsToAdd = 0
            
            if minute > 0 && minute < 15 {
                minutesToAdd = 15 - minute
            } else if minute > 15 && minute < 30 {
                minutesToAdd = 30 - minute
            } else if minute > 30 && minute < 45 {
                minutesToAdd = 45 - minute
            } else if minute > 45 {
                minutesToAdd = 60 - minute
            }
            
            secondsToAdd = minutesToAdd * 60

            return date + TimeInterval(secondsToAdd)
        }
    }
    
    static var toMidnight: Date {
        get {
            let date = Date()
            var calendar = Calendar.current
            
            if let timeZone = TimeZone(identifier: "CST") {
                calendar.timeZone = timeZone
            }
            
            let minute = calendar.component(.minute, from: date)
            let hour = calendar.component(.hour, from: date)
            
            let hoursToMinutes = hour * 60
            let minutesToSeconds = (minute + hoursToMinutes) * 60

            return date - TimeInterval(minutesToSeconds)
        }
    }
}
