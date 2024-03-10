//
//  ContentView.swift
//  UnitConverter
//
//  Created by Immanuel Matthews-Feemster on 3/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedUnitType = "Temp"
    @State private var convertFromUnit = "Fahrenheit"
    @State private var convertToUnit = "Celcius"
    @State private var convertFromUnitAmount = 0.0
    @State private var conversionUnits = ["Fahrenheit", "Celcius", "Kelvin"]
    @FocusState private var unitsAreFocused: Bool
    
    private let unitType = ["Temp", "Length", "Time", "Volume"]
    private let tempUnits = ["Fahrenheit", "Celcius", "Kelvin"]
    private let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    private let timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    private let volumeUnits = ["Milliters", "Liters", "Cups", "Pints", "Gallons"]
    
    private var convertToUnitAmount: Double {
        switch selectedUnitType {
        case "Temp":
            return convertTemp(convertFromUnitAmount, initialUnit: convertFromUnit, endingUnit: convertToUnit)
        case "Length":
            return convertLength(convertFromUnitAmount)
        case "Time":
            return convertTime(convertFromUnitAmount)
        case "Volume":
            return convertVolume(convertFromUnitAmount)
        default :
            return convertTemp(convertFromUnitAmount, initialUnit: convertFromUnit, endingUnit: convertToUnit)
        }
     }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit Type", selection: $selectedUnitType) {
                        ForEach(unitType, id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedUnitType) {
                        updateUnits(selectedUnitType)
                        
                        
                    }
                }
                Section(header: Text("Conversion Units")) {
                    VStack {
                        Picker("Select type", selection: $conversionUnits[0]) {
                            ForEach(conversionUnits, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        TextField("Enter value", value: $convertFromUnitAmount, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($unitsAreFocused)
                        Picker("Select type", selection: $conversionUnits[1]) {
                            ForEach(conversionUnits, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        Section("Amount per person.") {
                            Text(convertToUnitAmount, format: .number)
                        }

                    }
                }

            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if unitsAreFocused {
                    Button("Done") {
                        unitsAreFocused = false
                    }
                }
            }
        }
    }
    
    func updateUnits(_ unitIndex: String) {
        switch unitIndex {
        case "Temp":
            conversionUnits = tempUnits
        case "Length":
            conversionUnits = lengthUnits
        case "Time":
            conversionUnits = timeUnits
        case "Volume":
            conversionUnits = volumeUnits
        default :
            conversionUnits = ["updateUnitsError","switchFunctionError"]
        }
    }
    
    func convertTemp(_ initialAmount: Double, initialUnit: String, endingUnit: String) -> Double {
        var tempInKelvin = 0.0
        var convertedTemp = 0.0
        switch initialUnit {
        case "Fahrenheit":
            tempInKelvin = ((initialAmount - 32) * 5) / 9 + 273.15
        case "Celcius":
            tempInKelvin = initialAmount + 273.15
        case "Kelvin":
            tempInKelvin = initialAmount
        default :
            tempInKelvin = ((initialAmount - 32) * 5) / 9 + 273.15
        }
        
        switch endingUnit {
        case "Fahrenheit":
            convertedTemp = (tempInKelvin - 273.15) * 1.8 + 32
        case "Celcius":
            convertedTemp = tempInKelvin - 273.15
        case "Kelvin":
            convertedTemp = tempInKelvin
        default :
            convertedTemp = tempInKelvin
        }
        return convertedTemp
    }
    
    func convertLength(_ initialUnit: Double) -> Double {
        //Same logic as temp conversions, skipping conversion logic due to being a SWIFTUI learning project
        return initialUnit
    }
    
    func convertTime(_ initialUnit: Double) -> Double {
        //Same logic as temp conversions, skipping conversion logic due to being a SWIFTUI learning project
        return initialUnit
    }
    
    func convertVolume(_ initialUnit: Double) -> Double {
        //Same logic as temp conversions, skipping conversion logic due to being a SWIFTUI learning project
        return initialUnit
    }
}
#Preview {
    ContentView()
}

