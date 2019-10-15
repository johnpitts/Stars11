//
//  StarsTableViewCell.swift
//  Stars11
//
//  Created by John Pitts on 10/15/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class StarsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var star: Star? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
        guard let star = star else { return }
        nameLabel.text = star.name
        distanceLabel.text = "\(star.distance) light years away"
    }



}
