//
//  ContentView.swift
//  BetterRest
//
//  Created by Abdulkarim Mziya on 2026-04-20.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State var wakeUp = defaultWakeUpTime
    @State var sleepAmount = 8.0
    
    @State var showingAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    static var defaultWakeUpTime: Date {
        var component = DateComponents()
        component.hour = 7
        component.minute = 0
        
        return Calendar.current.date(from: component) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Set Your Wake up Time: ")
                        .font(.headline)
                    
                    DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Desired Amount of Sleep: ")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let component = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            
            let hour = (component.hour ?? 0) * 60 * 60
            let mins = (component.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + mins), estimatedSleep: sleepAmount)
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your Sleep time is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error..."
            alertMessage = "Unable to successfully calculate your Sleep time."
        }
        
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
