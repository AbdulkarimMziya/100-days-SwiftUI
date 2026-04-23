//
//  ContentView.swift
//  WordScramble
//
//  Created by Abdulkarim Mziya on 2026-04-21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var targetWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    TextField("Enter word",text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            VStack {
                Text("Score: \(score)")
                    .font(.title).bold()
            }
            .navigationTitle(targetWord)
            .toolbar {
                Button("Reset Game", action: resetGame)
            }
            .onSubmit(addWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addWord() {
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard word.count > 0 else { return }
        
        // Validate if word is unique
        guard isUnique(word: word) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: word) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(targetWord)'!")
            return
        }
        
        guard isValidWord(word: word) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard word.count > 3 else {
            wordError(title: "Too short", message: "Needs at least 3 letters")
            return
        }
        
        withAnimation {
            usedWords.insert(word, at: 0)
            score += word.count
        }
        newWord = ""
    }
    
    func startGame() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let content = try? String(contentsOf: fileURL, encoding: .utf8) {
                let startWords = content.components(separatedBy: "\n")
                targetWord = startWords.randomElement() ?? "Oranges"
            }
        } else {
            fatalError("Could not load start.txt from Bundle!!!")
        }
    
    }
    
    func isUnique(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempTargetWord = targetWord
        
        for letter in tempTargetWord {
            if let pos = tempTargetWord.firstIndex(of: letter) {
                tempTargetWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isValidWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func resetGame() {
        withAnimation {
            newWord = ""
            usedWords = []
        }
        startGame()
    }
}

#Preview {
    ContentView()
}
