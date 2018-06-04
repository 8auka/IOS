//
//  SecondViewController.swift
//  To Do List
//
//  Created by programming-xcode on 11/1/16.
//  Copyright © 2016 programming-xcode. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var todo: UITextField!
    @IBOutlet var button: UIButton!
    var todoarray = [String]()
    var todoarraydate = [Date]()

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(SecondViewController.check), userInfo: nil
            , repeats: true)
        if UserDefaults.standard.array(forKey: "todoarray") == nil {
            todoarray = [String]()
        } else {
            todoarray = UserDefaults.standard.array(forKey: "todoarray") as! [String]
        }
        
        if UserDefaults.standard.array(forKey: "todoarraydate") == nil {
            todoarraydate = [Date]()
        } else {
            todoarraydate = UserDefaults.standard.array(forKey: "todoarraydate") as! [Date]
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addtodo(_ sender: AnyObject) {
        let statictodo = todo.text!
        todoarray.append(statictodo)
        todoarraydate.append(Date.init(timeIntervalSinceNow: 0))
        todo.text = ""
        UserDefaults.standard.set(todoarray, forKey: "todoarray")
        UserDefaults.standard.set(todoarraydate, forKey: "todoarraydate")
        self.performSegue(withIdentifier: "Return", sender: self)
    }
    
    func check() {
        if todo.text == "" {
            button.isHidden = true
        } else {
            button.isHidden = false
        }
    }

}

