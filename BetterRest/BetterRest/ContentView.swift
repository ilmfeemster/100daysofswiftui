//
//  ContentView.swift
//  BetterRest
//
//  Created by Immanuel Matthews-Feemster on 3/22/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var sleepTime = Date.now
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("The recommended time to go to bed is:"){
                    Text(sleepTime, style: .time)
                        .font(.largeTitle)
                }
                .headerProminence(.increased)
                
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                Section("Daily coffee intake") {
                    Picker(selection: $coffeeAmount, label: Text("Cups of coffee")) {
                        ForEach(1...20, id: \.self) { cup in
                            Text("^[\(cup) cup](inflect: true)")
                        }
                    }
                }
            }
            .navigationTitle("BetterRest")
            .onChange(of: wakeUp, initial: true, {
                self.calculateBedtime()
            })
            .onChange(of: sleepAmount, initial: false, {
                self.calculateBedtime()
            })
            .onChange(of: coffeeAmount, initial: false, {
                self.calculateBedtime()
            })
        }
    }
    func calculateBedtime(){
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            self.sleepTime = sleepTime
        } catch {
            self.sleepTime = sleepTime
        }
    }
}

#Preview {
    ContentView()
}
