//
//  ScoreTableViewCell.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 12/4/23.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    static let identifier = "scoreTableViewCell"

    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var score: Score? {
        didSet {
            guard let model = score else { return }
            scoreLabel.text = "\(model.score)"
        }
    }
}
