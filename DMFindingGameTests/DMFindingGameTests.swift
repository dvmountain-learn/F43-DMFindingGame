//
//  DMFindingGameTests.swift
//  DMFindingGameTests
//
//  Created by David Ruvinskiy on 3/1/23.
//

import XCTest
@testable import DMFindingGame

final class DMFindingGameTests: XCTestCase {
    
    var viewController: GameViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = GameViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewController = nil
    }
    
    func testGenerateRandomLetters() {
        for _ in 1...100 {
            let targetLetter = viewController.gameBrain.letters.randomElement()!
            viewController.gameBrain.targetLetter = targetLetter
            
            let numLetters = Int.random(in: 1...12)
            viewController.gameBrain.newGame(numLetters: numLetters)
            let randomLetters = viewController.gameBrain.generateRandomLetters()
            
            XCTAssertEqual(randomLetters.count, numLetters)
            XCTAssertEqual(Set(randomLetters).count, randomLetters.count)
            XCTAssertTrue(randomLetters.contains(targetLetter))
        }
    }
    
    func testCalculateNewScore() {
        for _ in 1...100 {
            let targetLetter = viewController.gameBrain.letters.randomElement()!
            viewController.gameBrain.targetLetter = targetLetter
            
            let randomScore = Int.random(in: 1...100)
            viewController.gameBrain.score = randomScore
            
            let userChoseCorrectLetter = Bool.random()
            
            if userChoseCorrectLetter {
                viewController.gameBrain.letterSelected(letter: targetLetter)
                XCTAssertEqual(viewController.gameBrain.score, randomScore + 1)
            } else {
                let filteredArray = viewController.gameBrain.letters.filter { $0 != targetLetter }
                let randomLetter = filteredArray.randomElement()!
                viewController.gameBrain.letterSelected(letter: randomLetter)
                
                XCTAssertEqual(viewController.gameBrain.score, randomScore)
            }
        }
    }
    
    func testGameplay() {
        let gameBrain = GameBrain()
        
        for _ in 1...100 {
            let numLetters = Int.random(in: 1...12)
            gameBrain.newGame(numLetters: numLetters)
            let oldHighScore = gameBrain.highScore
            
            XCTAssertEqual(gameBrain.randomLetters.count, numLetters)
            XCTAssertEqual(Set(gameBrain.randomLetters).count, gameBrain.randomLetters.count)
            XCTAssertTrue(gameBrain.randomLetters.contains(gameBrain.targetLetter))
            XCTAssertEqual(gameBrain.score, 0)
            
            for _ in 1...50 {
                let oldScore = gameBrain.score
                
                let userChoseCorrectLetter = Bool.random()
                
                if userChoseCorrectLetter {
                    gameBrain.letterSelected(letter: gameBrain.targetLetter)
                    XCTAssertEqual(gameBrain.score, oldScore + 1)
                } else {
                    let filteredArray = gameBrain.letters.filter { $0 != gameBrain.targetLetter }
                    let randomLetter = filteredArray.randomElement()!
                    gameBrain.letterSelected(letter: randomLetter)
                    XCTAssertEqual(gameBrain.score, oldScore)
                }
                print(oldScore, oldHighScore)
                XCTAssertEqual(gameBrain.highScore, max(oldHighScore, gameBrain.score))
            }
        }
    }
}
