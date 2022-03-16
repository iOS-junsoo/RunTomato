//
//  Badge2TableViewCell.swift
//  Raising_tomatoes
//
//  Created by 준수김 on 2022/03/16.
//

import UIKit

class Badge2TableViewCell: UITableViewCell {

    @IBOutlet weak var persistenceImage1: UIImageView!
    @IBOutlet weak var persistenceImage2: UIImageView!
    @IBOutlet weak var persistenceImage3: UIImageView!
    @IBOutlet weak var persistenceImage4: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
