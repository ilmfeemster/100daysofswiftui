//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Immanuel Matthews-Feemster on 3/9/24.
//

import SwiftUI

struct FlagView: View {
    let country: String
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Russia", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingError = false
    @State private var showingEndGame = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var selectedCountry = ""
    @State private var alertMessage = ""
    @State private var round = 1
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagView(country: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(alertMessage)")
        }
        .alert(scoreTitle, isPresented: $showingEndGame) {
            Button("Restart?", action: newGame)
        } message: {
            Text("Game over. Your final score is \(score)")
            Text("Play again?")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            alertMessage = "Your score is \(score)"
        } else {
            score -= 1
            scoreTitle = "Wrong"
            selectedCountry = countries[number]
            alertMessage = "Wrong you selected \(selectedCountry)"
        }
        showingScore = true
        round += 1
    }
    
    func askQuestion() {
        if round < 9 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            scoreTitle = "Game over"
            showingEndGame = true
        }
    }
    
    func newGame() {
        score = 0
        round = 1
        askQuestion()
    }
}

#Preview {
    ContentView()
}
