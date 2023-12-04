//
//  GameViewController.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 11/10/23.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var targetLetterLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!

    var timer: Timer!
    let gameBrain = GameBrain.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameBrain.newGame(numLetters: 9)
        updateUI()
        configureTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: fireTimer(timer:))
        RunLoop.current.add(timer, forMode: .common)
        secondLabel.text = "Seconds: \(gameBrain.secondsRemaining)"
        print("\(gameBrain.secondsRemaining)")
    }
    
    func updateUI() {
        gameBrain.newRound()
        let letters = gameBrain.randomLetters
        anyTransition(targetLetterLabel, 1.0)
        
        secondLabel.text = "Seconds: \(gameBrain.secondsRemaining)"
        scoreLabel.text = "Score: \(gameBrain.score)"
        targetLetterLabel.text = gameBrain.targetLetter
        
        for i in 0..<letters.count {
            letterButtons[i].setTitle(letters[i], for: .normal)
            letterButtons[i].backgroundColor = letters[i] == gameBrain.targetLetter ? .systemRed : .systemCyan
            letterButtons[i].layer.cornerRadius = 10
            anyTransition(letterButtons[i], 1.0)
        }
    }
    
    func fireTimer(timer: Timer) {
        gameBrain.secondsRemaining -= 1
        updateUI()

        if gameBrain.secondsRemaining <= 0 {
            timer.invalidate()
            if gameBrain.score > 0 {
                CoreDataManager.shared.addScore(score: gameBrain.score)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        if gameBrain.score > 0 {
            CoreDataManager.shared.addScore(score: gameBrain.score)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        gameBrain.letterSelected(letter: sender.titleLabel?.text ?? "")
        updateUI()
    }
}
