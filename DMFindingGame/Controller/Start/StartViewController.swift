//
//  StartViewController.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 11/10/23.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var heigScoreLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heigScoreLabel.text = String(format: "Heig Score: %d", CoreDataManager.shared.calculateHighScore())
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "startGame", sender: self)
    }
    
    @IBAction func seeAllScoreButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueScores", sender: self)
    }
    
    @IBSegueAction
    private func actionShowScores(coder: NSCoder) -> ScoresViewController? {
        return ScoresViewController(coder: coder, scores: CoreDataManager.shared.fetchScores())
    }
}
