//
//  FindingGameViewController.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 11/7/23.
//

import UIKit

class FindingGameViewController: UIViewController {
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let targetLetterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 70, weight: .black)
        label.text = "W"
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let main = UIStackView()
        main.translatesAutoresizingMaskIntoConstraints = false
        main.distribution = .fillEqually
        main.axis = .vertical
        main.spacing = 20
        return main
    }()
    
    private var letterButtons: [UIButton]! = []
    
    var targetLetter = ""
    var randomLetters = [String]()
    var score = 0
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupUI
        self.newRound()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension FindingGameViewController {
    private var setupUI: () {
        view.addSubview(scoreLabel)
        view.addSubview(targetLetterLabel)
        view.addSubview(mainStackView)
        
        self.setupUIButton
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 25),
            scoreLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            scoreLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25),
            scoreLabel.heightAnchor.constraint(equalToConstant: 40),
            
            targetLetterLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            targetLetterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            targetLetterLabel.heightAnchor.constraint(equalToConstant: 100),
            
            mainStackView.topAnchor.constraint(equalTo: targetLetterLabel.bottomAnchor, constant: 50),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25),
            
        ])
    }
    
    private var setupUIButton: () {
        var index: Int = 0
        
        while index < 9 {
            let subStack = UIStackView()
            subStack.axis = .horizontal
            subStack.distribution = .fillEqually
            subStack.spacing = 20
            for _ in 0..<3 {
                if index < 9 {
                    let button = UIButton()
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.setTitleColor(.white, for: .normal)
                    button.titleLabel?.font = .systemFont(ofSize: 35, weight: .regular)
                    button.backgroundColor = .systemBlue.withAlphaComponent(0.6)
                    letterButtons.append(button)
                    subStack.addArrangedSubview(button)
                }
                index += 1
            }
            mainStackView.addArrangedSubview(subStack)
        }
    }
    
    private func targetLabelTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        targetLetterLabel.layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    func newRound() {
        self.targetLabelTransition(0.5)
        let randomLetter = Int.random(in: 1..<letters.count)
        targetLetter = letters[randomLetter]
        self.updateTargetLetterLabel()
        self.updateLetterButtons()
    }
    
    
    func generateRandomLetters(numLetters: Int) -> [String] {
        randomLetters = [targetLetter]
        while randomLetters.count < numLetters {
            let randLetter = Int.random(in: 1..<26)
            guard !randomLetters.contains(letters[randLetter]) else { continue }
            randomLetters.append(letters[randLetter])
        }
        return randomLetters.shuffled()
    }
    
    func calculateNewScore(selectedLetter: String) {
        if (selectedLetter == targetLetter) {
            score += 1
        }
    }
    
    func updateTargetLetterLabel() {
        targetLetterLabel.text = targetLetter
    }
    
    func updateScoreLabel() {
        scoreLabel.text = String(format: "%d", score)
    }
    
    func updateLetterButtons() {
        let randomLetters = self.generateRandomLetters(numLetters: 9)
        for i in 0..<randomLetters.count {
            letterButtons[i].setTitle(randomLetters[i], for: .normal)
            letterButtons[i].layer.borderColor = UIColor.white.cgColor
            letterButtons[i].layer.cornerRadius = 10
            letterButtons[i].layer.borderWidth = 2
            letterButtons[i].addTarget(self, action: #selector(clickActonButton(_:)), for: .touchUpInside)
        }
    }
    
    @objc func clickActonButton(_ sender: UIButton) {
        let button = sender.titleLabel
        self.calculateNewScore(selectedLetter: button?.text ?? "")
        self.updateScoreLabel()
        self.newRound()
    }
}
