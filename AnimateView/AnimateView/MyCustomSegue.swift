//
//  MyCustomSegue.swift
//  AnimateView
//
//  Created by Darkhan on 28.03.17.
//  Copyright © 2017 Suleyman Demirel University. All rights reserved.
//

import UIKit

class MyCustomSegue: UIStoryboardSegue {
    override func perform() {
        scale()
    }
    
    func scale(){
        let fromVC = self.source
        let toVC = self.destination
        toVC.view.transform = CGAffineTransform(translationX: -fromVC.view.bounds.width, y: fromVC.view.bounds.height)
        toVC.view.center = fromVC.view.center
        let containerView = fromVC.view.superview
        containerView?.addSubview(toVC.view)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { 
            toVC.view.transform = CGAffineTransform.identity
        }) { (success) in
            fromVC.present(toVC, animated: false, completion: nil)
        }
        
    }
}
