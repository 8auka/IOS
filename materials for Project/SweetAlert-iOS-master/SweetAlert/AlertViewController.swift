//
//  ViewController.swift
//  SweetAlert
//
//  Created by Codester on 11/3/14.
//  Copyright (c) 2014 Codester. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var alert = SweetAlert()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 242.0/255.0, green: 244.0/255.0, blue: 246.0/255.0, alpha: 1.0)
    }
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sucessAlert(_ sender: AnyObject) {
        _ = SweetAlert().showAlert("Good job!", subTitle: "You clicked the button!", style: AlertStyle.success)
    }
    
    @IBAction func customIconAlert(_ sender: AnyObject) {
        _ = SweetAlert().showAlert("Sweet!", subTitle: "Here's a custom image.", style: AlertStyle.customImag(imageFile: "thumb.jpg"))
    }
}

