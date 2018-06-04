//
//  ViewController.swift
//  Websites
//
//  Created by Bauyrzhan on 22.02.17.
//  Copyright © 2017 Bauyrzhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
   
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var Controller: UISegmentedControl!

    var titles : [String] = ["Apple", "Instagram", "Facebook", "VK"]
    var urls : [String] = ["https://apple.com","https://instagram.com","http://facebook.com","https://vk.com"]
    var titles_favourite: [String] = []
    var urls_favourite : [String] = []
    
    
    
    @IBAction func mySegment(_ sender: UISegmentedControl) {
        
        myTableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        myTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var return_value = 0
        switch(Controller.selectedSegmentIndex)
        {
        case 0:
            return_value = titles.count
            break
        case 1:
            return_value = titles_favourite.count
            break
        default:
            break
        }
        
        return return_value
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath )
        switch(Controller.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = titles[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = titles_favourite[indexPath.row]
            break
        default:
            break
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch(Controller.selectedSegmentIndex)
        {
        case 0:
            titles.remove(at: indexPath.row)
            urls.remove(at: indexPath.row)
            if (titles_favourite.contains(titles[indexPath.row]))
            {
                titles_favourite.remove(at: indexPath.row)
            }
            break
        case 1:
            titles_favourite.remove(at: indexPath.row)
            urls_favourite.remove(at: indexPath.row)
            break
        default:
            break
            
        }
        myTableView.reloadData()
    }
    
    func addFavourite(title : String, url : String) {
        titles_favourite.append(title)
        urls_favourite.append(url)
        myTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueWeb"
        {
            let destination = segue.destination as! WebViewController
            destination.view_protocol = self
            
            switch(Controller.selectedSegmentIndex)
            {
            case 0:
                destination.webView_url = urls[(myTableView.indexPathForSelectedRow?.row)!]
                destination.webView_title = titles[(myTableView.indexPathForSelectedRow?.row)!]
                destination.index = myTableView.indexPathForSelectedRow?.row
                break
            case 1:
                destination.webView_url = urls_favourite[(myTableView.indexPathForSelectedRow?.row)!]
                destination.webView_title = titles_favourite[(myTableView.indexPathForSelectedRow?.row)!]
                destination.index = myTableView.indexPathForSelectedRow?.row
                break
            default:
                break
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
