//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Abdulkarim Mziya on 2026-04-09.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy",
                                    "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var showFinalScore = false
    @State private var attempts = 8
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomLeading)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                
                Spacer()
                VStack(spacing: 30) {
                    VStack(spacing: 8) {
                        Text("Tap the flag of:")
                            .foregroundStyle(.secondary)
                            .font(.title)
                            .fontWeight(.medium)
                        
                        Text("\(countries[correctAnswer])")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                            // flag was tapped
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .foregroundStyle(.secondary)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
            .alert("You are \(scoreTitle)", isPresented: $showScore) {
                Button("Continue", role: .confirm) { askNextQuestion() }
            }
            .alert("Your Results: \(score)/8", isPresented: $showFinalScore) {
                Button("Restart Game", role: .confirm) { resetGame() }
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        showScore = true
        
        attempts -= 1
        if attempts < 1 {
            showFinalScore = true
        }
        
    }
    
    func askNextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        countries.shuffle()
        score = 0
        attempts = 8
        askNextQuestion()
    }
    
}

#Preview {
    ContentView()
}

