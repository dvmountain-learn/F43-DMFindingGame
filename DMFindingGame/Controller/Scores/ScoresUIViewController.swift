//
//  ScoresUIViewController.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 12/4/23.
//

import UIKit

class ScoresUIViewController: UIViewController {
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: ScoreTableViewCell.identifier)
        return table
    }()
    
    private var scores: [Score] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leftAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image:  UIImage(systemName: "xmark"),
            style: .plain, target: self, action: #selector(backButtonTapped(_:)))
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}

extension ScoresUIViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifier, for: indexPath) as? ScoreTableViewCell else { return UITableViewCell() }
        cell.score = scores[indexPath.row]
        
        return cell
    }
}

extension ScoresUIViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
