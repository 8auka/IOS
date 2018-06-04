//
//  TableViewCell.swift
//  Animation
//
//  Created by Bauka on 06.04.17.
//  Copyright © 2017 Bauka. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var but: UIButton!
   

    @IBAction func Flip1(_ sender: UIButton) {
        self.firstView.alpha = 1
        UIView.transition(from: secondView, to: firstView, duration: 0.5, options: .transitionFlipFromRight) { (success) in
            
        }
    }
    
    @IBAction func Flip2(_ sender: UIButton) {
        UIView.transition(from: firstView, to: secondView, duration: 0.4, options: .transitionFlipFromLeft) { (success) in
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstView.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapping))
        firstView.addGestureRecognizer(tap)
        
        
        // Initialization code
    }
    
    func tapping(){
       firstView.alpha = 0.2
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
