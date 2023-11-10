//
//  StartUIViewController.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 11/10/23.
//

import UIKit

class StartUIViewController: UIViewController {
    
    private let heigScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "High Score: 0"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 10
        return button
    }()
    
    var gameBrain = GameBrain.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupUI
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heigScoreLabel.text = String(format: "Heig Score: %d", gameBrain.highScore)
    }
}

extension StartUIViewController {
    private var setupUI: () {
        view.addSubview(heigScoreLabel)
        view.addSubview(startButton)
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            heigScoreLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -50),
            heigScoreLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: heigScoreLabel.bottomAnchor, constant: 10),
            startButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        startButton.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func startButtonTapped(_ sender: UIButton) {
        let vc = GameUIViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
