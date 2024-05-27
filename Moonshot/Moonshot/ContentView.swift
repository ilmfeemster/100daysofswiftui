//
//  ContentView.swift
//  Moonshot
//
//  Created by Immanuel Matthews-Feemster on 5/27/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(.example)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) {size, axis in
                size * 0.8
            }
    }
}

#Preview {
    ContentView()
}
