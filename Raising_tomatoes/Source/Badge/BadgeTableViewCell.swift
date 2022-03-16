//
//  BadgeTableViewCell.swift
//  Raising_tomatoes
//
//  Created by 준수김 on 2022/03/16.
//

import UIKit

class BadgeTableViewCell: UITableViewCell {

    @IBOutlet weak var TenacityImage1: UIImageView!
    @IBOutlet weak var TenacityImage2: UIImageView!
    @IBOutlet weak var TenacityImage3: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
