//
//  AppointmentDetailView.swift
//  Movemedical-JohnLollar
//
//  Created by John Lollar on 11/5/22.
//

import SwiftUI

struct AppointmentDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appointmentSections: AppointmentDictionary

    @State var appointment: Appointment
    @State private var showingAlert = false

    let locationChoices: [String] = ["", "San Diego", "St. George", "Park City", "Dallas", "Memphis", "Orlando"]
    
    var body: some View {
        Form {
            Section("Description") {
                TextField("Description", text: $appointment.description, axis: .vertical)
            }
            
            Section("Date & Time") {
                DatePicker("Date", selection: $appointment.date, in: Date.toMidnight...)
            }
            
            Section("Location") {
                Picker("Location", selection: $appointment.location) {
                    ForEach(locationChoices, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Section("") {
                Button {
                    if isValidForm() {
                        appointmentSections.saveAppointment(appointment: appointment)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        showingAlert = true
                    }
                } label: {
                    Text(appointment.description == "" ? "Save Appointment" : "Save Changes")
                        .foregroundColor(.cyan)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding()
                }
                .buttonStyle(.borderless)
            }
            
            Button {
                if isValidForm() {
                    appointmentSections.deleteAppointment(appointment: appointment)
                }
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text(appointment.description == "" ? "Cancel Appointment" : "Delete Appointment")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding()
            }
            .buttonStyle(.borderless)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Incomplete Form"), message: Text("Please make sure each section in the form is filled out"), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Appointment Details")
        .onAppear() {
            UIDatePicker.appearance().minuteInterval = 15
        }
    }

    func isValidForm() -> Bool {
        guard !appointment.location.isEmpty, !appointment.description.isEmpty else { return false }
        return true
    }
}

struct AppointmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentDetailView(appointment: Appointment(id: UUID(), date: Date.now, location: "", description: ""))
    }
}
