//
//  Movemedical_JohnLollarApp.swift
//  Movemedical-JohnLollar
//
//  Created by John Lollar on 11/4/22.
//

import SwiftUI

@main
struct Movemedical_JohnLollarApp: App {
    
    @StateObject var sortedAppointments: AppointmentDictionary = AppointmentDictionary(appointments: Appointment.fillerAppointments)
    
    var body: some Scene {
        WindowGroup {
            AppointmentListView()
                .environmentObject(sortedAppointments)
                .onAppear() {
                    UIApplication.shared.addTapGestureRecognizer()
                    #if DEBUG
                    // Silences warning about DatePicker constraints, that appears to be a bug in iOS 16
                    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    #endif
                }
        }
    }
}
