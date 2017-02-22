//
//  albumTableViewCell.swift
//  Music Search
//
//  Created by Pandu on 2/22/17.
//  Copyright © 2017 Pandurang Yachwad. All rights reserved.
//
// FUTURE - All potential improvement changes are commented with FUTURE

import UIKit

class albumTableViewCell: UITableViewCell {
    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var trackName: UILabel!
    @IBOutlet var albumName: UILabel!
    @IBOutlet var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
