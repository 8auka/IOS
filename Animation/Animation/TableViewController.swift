//
//  TableViewController.swift
//  Animation
//
//  Created by Bauka on 06.04.17.
//  Copyright © 2017 Bauka. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
        
    }
    var myCellPhone = ["Iphone 7 plus","Iphone 7","Iphone 6 plus","Blackberry","Samsung","MacPhone","Iphone 5S","Iphone SE"]
    var myCellPrice = ["3150$","850$","650$","350$","534$","1000$","8880$","340$"]
    
    var myCellPhone1 = ["A10 Fusion","GG21 RT","RTL plus","JHAD","Sama","MMM","UIB","HH SE"]
    var myCellPrice1 = ["315MP","85MP","65MP","35MP","53MP","100MP","88MP","34MP"]

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.label1.text = myCellPhone[indexPath.row]
         cell.label2.text = myCellPrice[indexPath.row]
        cell.text1.text = myCellPhone1[indexPath.row]
        cell.text2.text = myCellPrice1[indexPath.row]
        return cell
  
}
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myCellPhone.count
        
    }
    func animateTable(){
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: tableViewHeight, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter)*0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: ({
                cell.transform = CGAffineTransform.identity
                
            }), completion: nil)
            delayCounter += 1
        }
        
    
    }
    
    
}
