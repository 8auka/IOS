//
//  ViewController.swift
//  Animation
//
//  Created by Bauka on 06.04.17.
//  Copyright © 2017 Bauka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var square: UIView!
    @IBOutlet weak var otherbtn: UIButton!
 
    @IBOutlet weak var textField1: UITextField!
 
    @IBOutlet weak var textField2: UITextField!
    
    @IBAction func rotate(_ sender: Any) {
      UIView.animate(withDuration: 0.1, animations: ({
            self.otherbtn.transform = CGAffineTransform(rotationAngle: 30)
       })
        )
        
    }
    
    @IBAction func btn(_ sender: Any) {
        
        UIView.animate(withDuration: 3.0, animations: ({
            self.otherbtn.transform = CGAffineTransform(rotationAngle: 360)
            self.otherbtn.transform = CGAffineTransform(scaleX: 2000,y: 1000)
            
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0,animations: ({
                
                self.textField1.center.x = self.view.frame.width + 360
            }), completion: nil)
            
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0,animations: ({
                
                self.textField2.center.x = self.view.frame.width + 360
                
            }), completion: nil)
            
        }))}
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        otherbtn.alpha = 0
        otherbtn.layer.cornerRadius = 7.0
        otherbtn.layer.borderWidth = 2.0
        otherbtn.clipsToBounds = true
        textField1.center.x = self.view.frame.width + 360
        textField2.center.x = self.view.frame.width - 360
        UIView.animate(withDuration: 2.0, animations: ({
            self.otherbtn.alpha = 1
        }), completion: nil)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0,animations: ({
            
            self.textField1.center.x = self.view.frame.width
            
        }), completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0,animations: ({
            
            self.textField2.center.x = self.view.frame.width
            
        }), completion: nil)
        
        }
        
}






