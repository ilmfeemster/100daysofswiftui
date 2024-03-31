//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Immanuel Matthews-Feemster on 3/19/24.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    @State var computerMove = ""
    @State var shouldWin = true
    @State var score = 0
    @State var round = 0
    @State var gameOverTitle = ""
    @State var gameOverMessage = ""
    @State var gameOverShown = false
    
    var body: some View {
        NavigationStack{
            Section("Score: \(score)") {
                Text("Your opponent chose: \(computerMove)")
                Text("You need to " + (shouldWin ? "win" : "lose"))
            }
            .onAppear(perform: newRound)
            .navigationTitle("Rock, Paper, Scissors.")
            HStack {
                Button(action: {playRound("Rock")}, label: {
                    Text("Rock")
                })
                Button(action: {playRound("Paper")}, label: {
                    Text("Paper")
                })
                Button(action: {playRound("Scissors")}, label: {
                    Text("Scissors")
                })
            }.alert(gameOverTitle, isPresented: $gameOverShown) {} message: {
                Text(gameOverMessage)
            }
        }
    }
    
    func newRound() {
        computerMove = possibleMoves[Int.random(in: 0...2)]
        shouldWin = Bool.random()
    }
    
    func playRound(_ playerChoice: String) {
        guard !possibleMoves.contains(playerChoice) else {
            if playerChoice == "Rock" {
                chooseRock()
            }
            else if playerChoice == "Paper" {
                choosePaper()
            } else if playerChoice == "Scissors" {
                chooseScissors()
            }
            round += 1
            //Game ends after 10 rounds
            checkGameOver()
            newRound()
            return
        }
    }
    
    func chooseRock() {
        var didWin: Bool
        if computerMove == "Scissors" {
            didWin = true
        } else if (computerMove == "Paper") {
            didWin = false
        } else {
            //scenario where user picks same move as computer and get a draw/tie, automatically lose.
            didWin = !shouldWin
        }
        if didWin == shouldWin {
            score += 1
        }
    }
    
    func choosePaper() {
        var didWin: Bool
        if computerMove == "Rock" {
            didWin = true
        } else if (computerMove == "Scissors") {
            didWin = false
        } else {
            //scenario where user picks same move as computer and get a draw/tie, automatically lose.
            didWin = !shouldWin
        }
        if didWin == shouldWin {
            score += 1
        }
    }
    
    func chooseScissors() {
        var didWin: Bool
        if computerMove == "Paper" {
            didWin = true
        } else if (computerMove == "Rock") {
            didWin = false
        } else {
            //scenario where user picks same move as computer and get a draw/tie, automatically lose.
            didWin = !shouldWin
        }
        if didWin == shouldWin {
            score += 1
        }
    }

    func checkGameOver() {
        if round == 10 {
            gameOverTitle = "Game over."
            gameOverMessage = "Your score is \(score)"
            gameOverShown = true
        }
    }
}
    
    #Preview {
        ContentView()
    }
