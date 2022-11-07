//
//  AppointmentSection.swift
//  Movemedical-JohnLollar
//
//  Created by John Lollar on 11/6/22.
//

import Foundation

struct AppointmentSection: Hashable {
    var dayDate: Date
    var appointments = [Appointment]()
}
