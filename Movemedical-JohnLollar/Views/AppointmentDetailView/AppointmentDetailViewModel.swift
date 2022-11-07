//
//  AppointmentDetailViewModel.swift
//  Movemedical-JohnLollar
//
//  Created by John Lollar on 11/6/22.
//

import Foundation

class AppointmentDetailViewModel: ObservableObject {
    
    var appointmentSections: AppointmentDictionary?
    var appointment: Appointment?
    
    @Published var location: String = ""
    @Published var description: String = ""
    @Published var date: Date = Date.now
    @Published var showingAlert = false
    
    func setup(appointmentSections: AppointmentDictionary, appointment: Appointment) {
        self.appointmentSections = appointmentSections
        self.appointment = appointment
    }
    
    func deleteAppointment() {
        var index = -1

        for i in 0 ..< appointmentSections!.sortedDict.count {
            let dailyAppointments = appointmentSections!.sortedDict[i].value.appointments
            
            for j in 0 ..< dailyAppointments.count {
                if dailyAppointments[j].id == appointment!.id {
                    index = j
                }
            }
            
            if index != -1 {
                appointmentSections!.sortedDict[i].value.appointments.remove(at: index)
                break
            }
        }
    }
    
    func isValidForm() -> Bool {
        var isValid = true
        
        if location == "" { isValid = false }
        if description == "" { isValid = false }
        
        if isValid {
            return true
        } else {
            return false
        }
    }
    
    func save() {
        if isValidForm() {
            if appointment!.description != "" {
                deleteAppointment()
            }
            
            let appointment = Appointment(id: UUID(), date: date, location: location, description: description)
            let dayString = appointment.getDay()
            var alreadyDate = false
            
            for i in 0 ..< appointmentSections!.sortedDict.count {
                if appointmentSections!.sortedDict[i].key == dayString {
                    appointmentSections!.sortedDict[i].value.appointments.append(appointment)
                    alreadyDate = true
                }
            }
            
            if !alreadyDate {
                let section = AppointmentSection(dayDate: appointment.date, appointments: [appointment])
                let dict: Dictionary<String, AppointmentSection>.Element = (key: dayString, value: section)
                appointmentSections!.sortedDict.append(dict)
            }
            
            sortAppointments()
        } else {
            showingAlert = true
        }
    }
    
    func sortAppointments() {
        var unorderedDict = appointmentSections!.sortedDict
        
        for i in 0 ..< unorderedDict.count {
            let sorted = unorderedDict[i].value.appointments.sorted { $0.date < $1.date }
            unorderedDict[i].value.appointments = sorted
        }
        appointmentSections!.sortedDict = unorderedDict.sorted { $0.value.dayDate < $1.value.dayDate }
    }
}
