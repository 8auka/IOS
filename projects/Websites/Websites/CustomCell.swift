//
//  CustomCell.swift
//  Websites
//
//  Created by Bauyrzhan on 22.02.17.
//  Copyright © 2017 Bauyrzhan. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
     @IBOutlet weak var myLabel: UILabel!

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
