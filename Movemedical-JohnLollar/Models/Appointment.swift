//
//  Appointment.swift
//  Movemedical-JohnLollar
//
//  Created by John Lollar on 11/6/22.
//

import Foundation

struct Appointment: Identifiable, Hashable {
    var id: UUID
    var date: Date
    var location: String
    var description: String
    
    static var fillerAppointments: [Appointment] = [
        Appointment(id: UUID(), date: Date.madeupDate, location: "San Diego", description: "Catch up on progress from the previous week"),
        Appointment(id: UUID(), date: Date.madeupDate, location: "Dallas", description: "Meet with new financial advisor"),
        Appointment(id: UUID(), date: Date.madeupDate, location: "Memphis", description: "Talk about options to expand the business"),
        Appointment(id: UUID(), date: Date.madeupDate, location: "Orlando", description: "Discuss which Disney World park is the best")
    ]
    
    func getDay() -> String {
        let day = self.date.formatted(date: .abbreviated, time: .omitted)
        return day
    }
}
