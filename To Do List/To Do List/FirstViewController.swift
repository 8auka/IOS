//
//  FirstViewController.swift
//  To Do List
//
//  Created by programming-xcode on 11/1/16.
//  Copyright © 2016 programming-xcode. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var todoarray = [String]()
    var todoarraydate = [Date]()
    var refresher: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.array(forKey: "todoarray") == nil {
            todoarray = [String]()
            UserDefaults.standard.set(todoarray, forKey: "todoarray")
        } else {
            todoarray = UserDefaults.standard.array(forKey: "todoarray") as! [String]
        }
        
        if UserDefaults.standard.array(forKey: "todoarraydate") == nil {
            todoarraydate = [Date]()
            UserDefaults.standard.set(todoarraydate, forKey: "todoarraydate")
        } else {
            todoarraydate = UserDefaults.standard.array(forKey: "todoarraydate") as! [Date]
        }
        
        refresher = UIRefreshControl()
        
        refresher?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refresher?.addTarget(self, action: #selector(FirstViewController.refresh), for: UIControlEvents.valueChanged)
        
        self.tableView.addSubview(refresher!)
        
        refresh()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func refresh() {
        tableView.reloadData()
        refresher?.endRefreshing()
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todoarray.count == todoarraydate.count {
            return todoarray.count
        } else {
            return todoarraydate.count
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = todoarray[indexPath.row]
        cell?.detailTextLabel?.text = String(describing: todoarraydate[indexPath.row])
        return cell!
    }

    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    @IBAction func new(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "New To Do", sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoarray.remove(at: indexPath.row)
            todoarraydate.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(todoarray, forKey: "todoarray")
            UserDefaults.standard.set(todoarraydate, forKey: "todoarraydate")
        }
    }
    
}

