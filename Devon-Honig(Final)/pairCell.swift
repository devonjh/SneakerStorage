//
//  pairCell.swift
//  Devon-Honig(Final)
//
//  Created by Devon Honig on 4/29/18.
//  Copyright © 2018 Devon Honig. All rights reserved.
//

import UIKit

class pairCell: UITableViewCell {
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var pairImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
