//
//  EditViewController.swift
//  MapKitApplication
//
//  Created by Kairat on 02.04.17.
//  Copyright © 2017 Kairat. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class EditViewController: UIViewController {

    
    @IBOutlet weak var titleOfPlace: UITextField!
    
    @IBOutlet weak var subtitleOfPlace: UITextField!
    
    var titleToEdit: String?
    var subbtitleToEdit: String?
    var coordinateOfPlace: CLLocationCoordinate2D?
    var index = Int()
    var indexToDelete = Int()
    var mainVC: ViewController = ViewController()
    
    override func viewDidLoad() {
        titleOfPlace.text = titleToEdit
        subtitleOfPlace.text = subbtitleToEdit
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        mainVC.mapView.removeAnnotation(mainVC.mapView.annotations[indexToDelete])
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        mainVC.places[index].title = titleOfPlace.text
        mainVC.places[index].subtitle = subtitleOfPlace.text
        appDelegate.saveContext()
        
        mainVC.data.listOfPlaces[index].nameOfPlace = titleOfPlace.text
        mainVC.data.listOfPlaces[index].titleOfPlace = subtitleOfPlace.text
        
        
        mainVC.showPlace(place: mainVC.data.listOfPlaces[index])
        mainVC.myTableView.reloadData()
        let nvc : UINavigationController = navigationController!
        nvc.popViewController(animated: true)
    }

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let nvc : UINavigationController = navigationController!
        nvc.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
