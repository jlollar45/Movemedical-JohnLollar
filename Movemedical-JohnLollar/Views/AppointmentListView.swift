//
//  ContentView.swift
//  Movemedical-JohnLollar
//
//  Created by John Lollar on 11/4/22.
//

import SwiftUI

struct AppointmentListView: View {
    
    @EnvironmentObject var apptDict: AppointmentDictionary
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(apptDict.sortedDict, id: \.key) { apptSection in
                    Group {
                        if apptSection.value.appointments.count == 0 {
                            EmptyView()
                        } else {
                            AppointmentSectionView(apptSection: apptSection)
                        }
                    }
                }
                NavigationLink(value: Appointment(id: UUID(), date: Date.toInterval, location: "", description: "")) {
                    Text("Add Appointment")
                        .foregroundColor(.cyan)
                }
            }
            .navigationTitle("Appointments")
            .navigationDestination(for: Appointment.self) { selectedAppointment in
                AppointmentDetailView(appointment: selectedAppointment)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentListView()
    }
}

struct AppointmentView: View {
    
    var appointment: Appointment
    
    var body: some View {
        HStack {
            NavigationLink(value: appointment) {
                Text(appointment.date.formatted(date: .omitted, time: .shortened))
                    .frame(minWidth: 80)
                Divider()
                Text(appointment.description)
            }
        }
    }
}

struct AppointmentSectionView: View {
    
    var apptSection: Dictionary<String, AppointmentSection>.Element
    
    var body: some View {
        Section (apptSection.key) {
            ForEach(Array(apptSection.value.appointments), id: \.self) { appointment in
                AppointmentView(appointment: appointment)
            }
        }
    }
}
