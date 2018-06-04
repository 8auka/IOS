//
//  ViewController.swift
//  AnimateView
//
//  Created by Darkhan on 27.03.17.
//  Copyright © 2017 Suleyman Demirel University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var popUpView2: UIView!
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var alertIsHere: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        blurView.alpha = 0.0
        popUpView.alpha = 1.0
        popUpView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    
    @IBAction func noCliked() {
        self.popUpView2.alpha = 1
        UIView.transition(from: popUpView, to: popUpView2, duration: 0.5, options: .transitionFlipFromTop) { (success) in
            
        }
    }
    
    @IBAction func backisPressed() {
        self.popUpView.alpha = 1
        UIView.transition(from: popUpView2, to: popUpView, duration: 0.5, options: .transitionFlipFromTop) { (success) in
            
        }
     
        
    }
    @IBAction func callPopUp(_ sender: UIBarButtonItem) {
        
        if !alertIsHere{
            alertIsHere = true
            
        }else{
            alertIsHere = false
        }
        
        if !alertIsHere{
            UIView.animate(withDuration: 0.5, animations: {
                self.blurView.alpha = 0.0
                self.popUpView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            }, completion: nil)
        }else if alertIsHere{
            UIView.animate(withDuration: 0.5, animations: {
                self.blurView.alpha = 1.0
                self.popUpView.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        
    }
    
}

