//
//  ScoresViewController.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 12/4/23.
//

import UIKit

class ScoresViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var scores: [Score]
    
    required init?(coder: NSCoder, scores: [Score]) {
        self.scores = scores
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        self.title = "Scores"
    }
    
    fileprivate func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: ScoreTableViewCell.identifier)
        self.tableView.reloadData()
    }
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}

extension ScoresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifier, for: indexPath) as? ScoreTableViewCell else { return UITableViewCell() }
        cell.score = scores[indexPath.row]
        
        return cell
    }
}

extension ScoresViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
