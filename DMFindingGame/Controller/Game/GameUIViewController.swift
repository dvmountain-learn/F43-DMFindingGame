//
//  GameUIViewController.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 11/7/23.
//

import UIKit

class GameUIViewController: UIViewController {
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "Score: 0"
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "Seconds: 0"
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
    
    var timer: Timer!
    let gameBrain = GameBrain.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupUI
        gameBrain.newGame(numLetters: 9)
        updateUI()
        configureTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
}

extension GameUIViewController {
    private var setupUI: () {
        view.addSubview(scoreLabel)
        view.addSubview(secondLabel)
        view.addSubview(targetLetterLabel)
        view.addSubview(mainStackView)
        
        self.setupUIButton
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            scoreLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25),
            scoreLabel.heightAnchor.constraint(equalToConstant: 40),
            
            secondLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            secondLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            secondLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25),
            secondLabel.heightAnchor.constraint(equalToConstant: 40),
            
            targetLetterLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 10),
            targetLetterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            targetLetterLabel.heightAnchor.constraint(equalToConstant: 100),
            
            mainStackView.topAnchor.constraint(equalTo: targetLetterLabel.bottomAnchor, constant: 30),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25),
        ])
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain, target: self, action: #selector(backButtonTapped(_:)))
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
                    button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
                    button.backgroundColor = .systemCyan
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
    
    func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: fireTimer(timer:))
        RunLoop.current.add(timer, forMode: .common)
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
            letterButtons[i].backgroundColor = .systemCyan
            letterButtons[i].backgroundColor = letters[i] == gameBrain.targetLetter ? .systemRed : .systemCyan
            letterButtons[i].layer.cornerRadius = 10
            anyTransition(letterButtons[i], 1.0)
            letterButtons[i].addTarget(self, action: #selector(clickActonButton(_:)), for: .touchUpInside)
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
    
    @objc func clickActonButton(_ sender: UIButton) {
        gameBrain.letterSelected(letter: sender.titleLabel?.text ?? "")
        updateUI()
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        if gameBrain.score > 0 {
            CoreDataManager.shared.addScore(score: gameBrain.score)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
