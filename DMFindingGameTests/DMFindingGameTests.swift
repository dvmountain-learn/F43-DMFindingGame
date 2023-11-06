//
//  DMFindingGameTests.swift
//  DMFindingGameTests
//
//  Created by David Ruvinskiy on 3/1/23.
//

import XCTest
@testable import DMFindingGame

final class DMFindingGameTests: XCTestCase {
    
    var viewController: DMFindingGameViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = DMFindingGameViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewController = nil
    }
    
    func testGenerateRandomLetters() {
        for _ in 1...100 {
            let targetLetter = viewController.letters.randomElement()!
            viewController.targetLetter = targetLetter
            
            let numLetters = Int.random(in: 1...12)
            let randomLetters = viewController.generateRandomLetters(numLetters: numLetters)
            
            XCTAssertEqual(randomLetters.count, numLetters)
            XCTAssertEqual(Set(randomLetters).count, randomLetters.count)
            XCTAssertTrue(randomLetters.contains(targetLetter))
        }
    }
    
    func testCalculateNewScore() {
        for _ in 1...100 {
            let targetLetter = viewController.letters.randomElement()!
            viewController.targetLetter = targetLetter
            
            let randomScore = Int.random(in: 1...100)
            viewController.score = randomScore
            
            let userChoseCorrectLetter = Bool.random()
            
            if userChoseCorrectLetter {
                viewController.calculateNewScore(selectedLetter: targetLetter)
                XCTAssertEqual(viewController.score, randomScore + 1)
            } else {
                let filteredArray = viewController.letters.filter { $0 != targetLetter }
                let randomLetter = filteredArray.randomElement()!
                viewController.calculateNewScore(selectedLetter: randomLetter)
                
                XCTAssertEqual(viewController.score, randomScore)
            }
        }
    }
}
