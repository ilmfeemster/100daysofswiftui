//
//  ContentView.swift
//  UnitConverter
//
//  Created by Immanuel Matthews-Feemster on 3/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedUnitType = "Temperature"
    
    private let unitType = ["Temp", "Length", "Time", "Volume"]
    
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
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
    
}

#Preview {
    ContentView()
}

