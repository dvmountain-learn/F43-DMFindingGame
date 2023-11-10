//
//  GameBrain.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 11/10/23.
//

import Foundation

class GameBrain {
    
    static let shared = GameBrain()
    
    var targetLetter: String = ""
    var randomLetters: [String] = []
    var score: Int = 0
    var highScore: Int = 0
    var numLetters: Int = 0
    var secondsRemaining: Int = 30
    let letters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    func generateRandomLetters() -> [String] {
        randomLetters = [targetLetter]
        
        while randomLetters.count < numLetters {
            let randLetter = Int.random(in: 1..<letters.count)
            guard !randomLetters.contains(letters[randLetter]) else { continue }
            randomLetters.append(letters[randLetter])
        }
        return randomLetters.shuffled()
    }
    
    func newRound() {
        let indexOfElement = Int.random(in: 1..<letters.count)
        targetLetter = letters[indexOfElement]
        randomLetters = generateRandomLetters()
    }
    
    func newGame(numLetters: Int) {
        self.numLetters = numLetters
        self.score = 0
        self.secondsRemaining = 30
        self.newRound()
    }
    
    func letterSelected(letter: String) {
        if letter == targetLetter {
            score += 1
            if score > highScore {
                highScore = score
            }
        }
    }
}
