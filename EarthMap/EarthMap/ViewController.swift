//
//  ViewController.swift
//  EarthMap
//
//  Created by Bauyrzhan on 29.03.17.
//  Copyright © 2017 Bauyrzhan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var mapsTableView: UITableView!
    @IBOutlet weak var mapTitleLabel: UILabel!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var mapStyleSegment: UISegmentedControl!
    @IBOutlet weak var dataView: UIView!
    
    
    var maps : [MAP] = Array()
    var didAppear : Int = Int()
    var j : Int = 0
    
    
    @IBAction func data(_ sender: UIBarButtonItem) {
        didAppear += 1
        if didAppear % 2 != 0 {
            self.dataView.isHidden = false
        } else {
            self.dataView.isHidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        maps = getData()
        
        if maps.isEmpty == false {
            for i in 0...maps.count-1 {
                let annon = CLLocationCoordinate2DMake(maps[i].lat, maps[i].long)
                myMap.setRegion(MKCoordinateRegionMakeWithDistance(annon, 1000, 1000), animated: true)
                let my_annotation = MKPointAnnotation()
                my_annotation.coordinate = annon
                my_annotation.title = maps[i].myTitle
                my_annotation.subtitle = maps[i].mySubtitle
                self.placeName.text = maps[i].myTitle
                myMap.addAnnotation(my_annotation)
            
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        maps = getData()
        mapsTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(maps[indexPath.row])
            maps.remove(at: indexPath.row)
            mapsTableView.reloadData()
            appDelegate.saveContext()
            self.mapsTableView.reloadData()
            super.viewDidLoad()
            self.viewDidLoad()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = maps[indexPath.row].myTitle
        cell?.detailTextLabel?.text = maps[indexPath.row].mySubtitle
        self.viewDidLoad()
        return cell!
    }
    
    @IBAction func tappedOnMap(_ sender: UILongPressGestureRecognizer) {
        
        let location = sender.location(in: self.myMap)
        let coordinate = self.myMap.convert(location, toCoordinateFrom: self.myMap)
        self.mapsTableView.reloadData()
        
        let myAlert = UIAlertController(title: "Add Website", message: "Fill all blanks", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
            (action : UIAlertAction!) -> Void in
            self.mapsTableView.reloadData()
            
        })
        let addAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            self.mapsTableView.reloadData()
            
            
            let titleField = myAlert.textFields![0] as UITextField
            let subtitleField = myAlert.textFields![1] as UITextField
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let map = MAP(context: context)
            self.mapsTableView.reloadData()
            
            map.myTitle = titleField.text
            map.mySubtitle = subtitleField.text
            let lat : NSNumber = NSNumber(value: coordinate.latitude)
            let lng : NSNumber = NSNumber(value: coordinate.longitude)
            map.lat = Double(lat)
            map.long = Double(lng)
            appDelegate.saveContext()
            
            self.myMap.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, 500, 500), animated: true)
            let my_annotation = CustomAnnotation(coordinate: coordinate, title: titleField.text!, subtitle: subtitleField.text!)
            self.placeName.text = titleField.text
            self.myMap.addAnnotation(my_annotation)
            self.mapsTableView.reloadData()
        })
        
        myAlert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Title"
        }
        myAlert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Subtitle"
        }
        myAlert.addAction(cancelAction)
        myAlert.addAction(addAction)
        self.present(myAlert, animated: true, completion: nil)
        
        self.mapsTableView.reloadData()
        self.viewDidLoad()
    }

    @IBAction func mySegment(_ sender: UISegmentedControl) {
        super.viewDidLoad()
        switch mapStyleSegment.selectedSegmentIndex {
        case 0:
            myMap.mapType = .standard
            break
        case 1:
            myMap.mapType = .satellite
            break
        case 2:
            myMap.mapType = .hybrid
            break
        default:
            break
        }
    }
    func getData() -> [MAP]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do{
            maps =  try context.fetch(MAP.fetchRequest())
        }catch{
            print("Fetching failed!!!")
        }
        return maps
    }

}

