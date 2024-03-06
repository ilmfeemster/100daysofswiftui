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
    
    private let unitType = ["Temp", "Length", "Time", "Volume"]
    private let tempUnits = ["Fahrenheit", "Celcius", "Kelvin"]
    private let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    private let timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    private let volumeUnits = ["Milliters", "Liters", "Cups", "Pints", "Gallons"]
    
    @State private var conversionUnits = ["Fahrenheit", "Celcius", "Kelvin"]
    
    
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
                Section {
                    Picker("Conversion Units", selection: $conversionUnits[0]) {
                        ForEach(conversionUnits, id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }
                    Picker("Conversion Units", selection: $conversionUnits[1]) {
                        ForEach(conversionUnits, id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }

                }

            }
            .navigationTitle("Unit Converter")
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
}
#Preview {
    ContentView()
}

