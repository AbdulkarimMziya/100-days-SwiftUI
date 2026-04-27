//
//  ContentView.swift
//  Edutainment
//
//  Created by Abdulkarim Mziya on 2026-04-25.
//

import SwiftUI

struct GameSettingsView: View {
    @Binding var multiplicationTable: Int
    @Binding var numberOfQuestionsSelected: Int
    @Binding var isGameStarted: Bool
    @Binding var currentOptions: [Int]
    @Binding var remainingAttempts: Int
    
    let options: [Int]
    var onStart: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Section {
                HStack {
                    
                           
                    Text("Choose Multiplication:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Picker("Multiplication Table", selection: $multiplicationTable) {
                        ForEach(2..<13, id: \.self) {
                            Text("\($0)")
                                
                        }
                    }
                    .pickerStyle(.menu)
                
                }
                
            }
            
            Section {
                Text("Number of Questions:")
                    .fontWeight(.semibold)
                Picker("Number of Questions", selection: $numberOfQuestionsSelected) {
                    ForEach(options, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Button {
                onStart()
            } label: {
                Text("Start Game")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.primary)
                    .font(.headline)
                    .background(.ultraThickMaterial)
                    .clipShape(.capsule)
                    
            }
        }
    }
}

struct GameDisplayView: View {
    let multipleOf: Int
    let multiplier: Int
    
    let answerOptions: [Int]
    
    var onAnswerSelected: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .firstTextBaseline) {
                Text("What is")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                Text("\(multipleOf) X \(multiplier) = ?")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.primary)
            }
            
            Section("Select the correct result:") {
                ForEach(answerOptions, id: \.self) { answer in
                    Button {
                        onAnswerSelected(answer)
                    }label: {
                        Text("\(answer)")
                            .padding(.vertical, 8)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity)
                            .background()
                            .clipShape(.rect(cornerRadius: 16))
                    }
                }
                
            }
            
        }
    }

}

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numberOfAttempts = 5
    @State private var isGameStarted = false
    
    @State private var multipliers = [2,3,4,5,6,7,8,9,10,11,12].shuffled()
    @State private var selectedMultiplier = Int.random(in: 0..<3)
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var score = 0
    
    let numberOfQuestions = [5,10,15]
    
    @State private var currentOptions = [Int]()
    @State private var remainingAttempts = 5
       
    var correctAnswer: Int {
        let multiplier = multipliers[selectedMultiplier]
        
        return multiplicationTable * multiplier
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    
                    VStack(spacing: 32) {
                        Text("Edutainment")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        if isGameStarted {
                            Text("* Multiples of \(multiplicationTable) *")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    
                    }
                    .foregroundStyle(.white)
                    
                    Spacer()
                    
                    if !isGameStarted{
                        GameSettingsView(
                            multiplicationTable: $multiplicationTable,
                            numberOfQuestionsSelected: $numberOfAttempts,
                            isGameStarted: $isGameStarted,
                            currentOptions: $currentOptions,
                            remainingAttempts: $remainingAttempts,
                            options: numberOfQuestions
                        ) {
                            remainingAttempts = numberOfAttempts
                            currentOptions = generateAnswerOptions()
                            isGameStarted = true
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 16))
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    } else {
                        
                        GameDisplayView(
                            multipleOf: multiplicationTable,
                            multiplier: multipliers[selectedMultiplier],
                            answerOptions: currentOptions
                        ) { selectedAnswer in
                            checkAnswer(selectedAnswer)
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 16))
                        .transition(.slide)
                        
                        Spacer()
                        
                        Text("Score: \(score)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                .padding()
                .alert(alertMessage, isPresented: $showAlert) {
                    if remainingAttempts < 1 {
                        Button("Restart") { resetGame() }
                        Button("Exit") { isGameStarted.toggle() }
                    } else {
                        Button("Next", role: .confirm) { nextQuestion() }
                    }
                }
                
            }
            
        }
    }
    
    func resetGame() {
        multipliers = multipliers.shuffled()
        selectedMultiplier = Int.random(in: 0..<3)
        
        // reset remaining attempts
        remainingAttempts = numberOfAttempts
        
        // Reset Scores
        score = 0
    }
    
    func generateAnswerOptions() -> [Int] {
        let correctAnswer = correctAnswer
        
        var options = Set<Int>()
        options.insert(correctAnswer)
        
        var usedMultipliers = Set<Int>()
        usedMultipliers.insert(selectedMultiplier)
        
        while options.count < 4 {
            let randomMultiplier = Int.random(in: 2...12)
                
            // Only add if this multiplier hasn't been used yet
            if !usedMultipliers.contains(randomMultiplier) {
                let wrongAnswer = multiplicationTable * randomMultiplier
                options.insert(wrongAnswer)
                usedMultipliers.insert(randomMultiplier)
            }
        }
        
        
        return Array(options.shuffled())
    }
    
    func checkAnswer(_ selectedAnswer: Int ) {
        if selectedAnswer == correctAnswer {
            
            // Update Score
            score += 1
            
            // alert message
            alertMessage = "Correct!!"
            
            
        } else {
            alertMessage = "Wrong!!"
        }
        
        remainingAttempts -= 1
        if remainingAttempts < 1 {
            // Show final score
            alertMessage = "Score: \(score)/\(numberOfAttempts)"
        }
        showAlert = true
    }
    
    func nextQuestion() {
        multipliers = multipliers.shuffled()
        selectedMultiplier = Int.random(in: 0..<3)
        currentOptions = generateAnswerOptions()
    }
}

#Preview {
    ContentView()
}
