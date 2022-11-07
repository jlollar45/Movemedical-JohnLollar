//
//  AppointmentDictionary.swift
//  Movemedical-JohnLollar
//
//  Created by John Lollar on 11/6/22.
//

import Foundation

class AppointmentDictionary: ObservableObject {
    var appointments: [Appointment]
    var dict = [String: AppointmentSection]()
    @Published var sortedDict = [Dictionary<String, AppointmentSection>.Element]()
    
    init(appointments: [Appointment]) {
        self.appointments = appointments
        
        for appointment in appointments {
            let day = appointment.getDay()

            var apptSection = dict[day]

            if apptSection != nil {
                apptSection!.appointments.append(appointment)
                dict[day] = apptSection
            } else {
                var apptSection = AppointmentSection(dayDate: appointment.date)
                apptSection.appointments.append(appointment)
                dict[day] = apptSection
            }
        }

        for (key, value) in dict {
            let sorted = value.appointments.sorted { $0.date < $1.date }
            dict[key]!.appointments = sorted
        }

        sortedDict = dict.sorted { $0.value.dayDate < $1.value.dayDate }
    }
    
    func sortDict() {
        for i in 0 ..< sortedDict.count {
            let sorted = sortedDict[i].value.appointments.sorted { $0.date < $1.date }
            sortedDict[i].value.appointments = sorted
        }
        sortedDict = sortedDict.sorted { $0.value.dayDate < $1.value.dayDate }
    }
    
    func deleteAppointment(appointment: Appointment) {
        var index = -1

        for i in 0 ..< sortedDict.count {
            let dailyAppointments = sortedDict[i].value.appointments
            
            for j in 0 ..< dailyAppointments.count {
                if dailyAppointments[j].id == appointment.id {
                    index = j
                }
            }
            
            if index != -1 {
                sortedDict[i].value.appointments.remove(at: index)
                break
            }
        }
    }
    
    func saveAppointment(appointment: Appointment) {
        if appointment.description != "" {
            deleteAppointment(appointment: appointment)
        }
        
        let newAppointment = Appointment(id: UUID(), date: appointment.date, location: appointment.location, description: appointment.description)
        let dayString = appointment.getDay()
        var alreadyDate = false
        
        for i in 0 ..< sortedDict.count {
            if sortedDict[i].key == dayString {
                sortedDict[i].value.appointments.append(newAppointment)
                alreadyDate = true
            }
        }
        
        if !alreadyDate {
            let section = AppointmentSection(dayDate: newAppointment.date, appointments: [newAppointment])
            let dict: Dictionary<String, AppointmentSection>.Element = (key: dayString, value: section)
            sortedDict.append(dict)
        }
        
        sortDict()
    }
}
