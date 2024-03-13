//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Immanuel Matthews-Feemster on 3/10/24.
//

import SwiftUI

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)

    }
}

extension View {
    func blueTitleStyle() -> some View {
        modifier(BlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello Title")
            .blueTitleStyle()
    }
}

#Preview {
    ContentView()
}
