//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Immanuel Matthews-Feemster on 3/19/24.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    @State var currentMove = "Rock"
    //WL = win/lose
    @State var currentWL = "Win"
    @State var score = 0
    
    var body: some View {
        VStack {
            
            Text(score, format: .number)
            Text(currentMove)
            Text(currentWL)
        }
    }
}
    
    #Preview {
        ContentView()
    }
