//
//  ViewController.swift
//  MapKitApplication
//
//  Created by Kairat on 02.04.17.
//  Copyright © 2017 Kairat. All rights reserved.
//

import UIKit
import MapKit
import CoreData


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var blurViewWithTable: UIVisualEffectView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var leftSide: UIView!
    
    @IBOutlet weak var rightSide: UIView!
    
    @IBOutlet weak var noPlacesLabel: UILabel!
    
    var data: MapKitAppMVC = MapKitAppMVC()
    var tableShowed = false
    var currentPlace: AnnotationOfPlace!
    var currentIndexOfPlace: Int?
    var places: [CustomPlace] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //addGoForwardGesture()
        //addGoBackwardGesture()
        
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        mapView.mapType = .standard
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longTappedOnMap(_:)))
        self.mapView.addGestureRecognizer(longPressRecognizer)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        places = getData()
        myTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.listOfPlaces.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = data.listOfPlaces[indexPath.row].nameOfPlace
        cell.detailTextLabel?.text = data.listOfPlaces[indexPath.row].titleOfPlace
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        deleteFromCore(atIndex: indexPath.row)
        mapView.removeAnnotation(mapView.annotations[indexPath.row])
        data.listOfPlaces.remove(at: indexPath.row)
                if data.listOfPlaces.count == 0{
                    self.title = ""
                    noPlacesLabel.isHidden = false
                }else{
                    if !contains(place: currentPlace){
                        goForward()
                    }
                }
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let annotation = data.listOfPlaces[indexPath.row]
        showPlace(place: annotation)
        blurViewWithTable.isHidden = true
        bottomView.isHidden = true
        tableShowed = false
        self.myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            print("Pinview was nil")
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        let button = UIButton(type: .detailDisclosure) as UIButton // button with info sign in it
        pinView?.rightCalloutAccessoryView = button
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "editAnnotation", sender: view)
        }
    }

    
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            mapView.mapType = .standard
        }else if sender.selectedSegmentIndex == 1{
            mapView.mapType = .satellite
        }else{
            mapView.mapType = .hybrid
        }
    }

    
    
    
    
    
    
    func longTappedOnMap(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.mapView)
        let coordinate = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        let alert = UIAlertController(title: "Add Place", message: "Fill all the fields", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: {action
            in let Title = alert.textFields![0].text
            let Subtitle = alert.textFields![1].text
            if Title != "" && Subtitle != ""{
                let annotation = AnnotationOfPlace(name: Title!, title: Subtitle!, coordinate: coordinate)
                self.data.listOfPlaces.append(annotation)
                self.addAnnotation(place: annotation)
                self.addToCore(place: annotation)
                self.showPlace(place: annotation)
            }
            self.noPlacesLabel.isHidden = true
            
            self.myTableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        alert.addTextField{ textField in
            textField.placeholder = "Title of place"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Subtitle of place"
        }
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func showListOfCities(_ sender: UIBarButtonItem) {
        if !tableShowed && data.listOfPlaces.count == 0{
            blurViewWithTable.isHidden = false
            bottomView.isHidden = false
            noPlacesLabel.isHidden = false
        }else{
            if tableShowed{
                blurViewWithTable.isHidden = true
                bottomView.isHidden = true
                noPlacesLabel.isHidden = true
            }else{
                blurViewWithTable.isHidden = false
                bottomView.isHidden = false
                noPlacesLabel.isHidden = true
            }
        }
        tableShowed = !tableShowed
    }
    
    func showPlace(place: AnnotationOfPlace){
        currentPlace = place
        currentIndexOfPlace = getIndex(place: place)
        self.title = self.currentPlace.nameOfPlace
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(place.coordinateOfPlace, 100000, 100000), animated: true)
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAnnotation"{
            let destination = segue.destination as! EditViewController
            destination.titleToEdit = (sender as! MKAnnotationView).annotation!.title!
            destination.subbtitleToEdit = (sender as! MKAnnotationView).annotation!.subtitle!
            destination.coordinateOfPlace = (sender as! MKAnnotationView).annotation!.coordinate
            destination.index = self.getIndexOfPlace(annotation: (sender as! MKAnnotationView).annotation! as! MKPointAnnotation)
            destination.indexToDelete = self.getIndexToDelete(annotation: (sender as! MKAnnotationView).annotation! as! MKPointAnnotation)
            destination.mainVC = self
        }
    }
    
    func getIndexOfPlace(annotation: MKPointAnnotation) -> Int{
        var index = 0
        for place in data.listOfPlaces{
            if place.nameOfPlace == annotation.title && place.titleOfPlace == annotation.subtitle && place.coordinateOfPlace.latitude == annotation.coordinate.latitude && place.coordinateOfPlace.longitude == annotation.coordinate.longitude{
                break
            }
            index = index + 1
        }
        return index
    }
    func getIndexToDelete(annotation: MKPointAnnotation) -> Int{
        var index = 0
        for place in self.mapView.annotations{
            if place.title!! == annotation.title! && place.subtitle!! == annotation.subtitle! && place.coordinate.latitude == annotation.coordinate.latitude && place.coordinate.longitude == annotation.coordinate.longitude{
                break
            }
            index = index + 1
        }
        return index
    }
    
    func addGoForwardGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(goForward))
        tap.numberOfTapsRequired = 2
        rightSide.addGestureRecognizer(tap)
    }
    func addGoBackwardGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBackward))
        tap.numberOfTapsRequired = 2
        leftSide.addGestureRecognizer(tap)
    }
    func goForward(){
        if data.listOfPlaces.count == 0{
            print("List is empty")
        }else{
            if contains(place: currentPlace){
                if currentIndexOfPlace! + 1 == data.listOfPlaces.count{
                    showPlace(place: data.listOfPlaces[0])
                }else{
                    showPlace(place: data.listOfPlaces[currentIndexOfPlace!+1])
                }
            }else{
                if data.listOfPlaces.count <= currentIndexOfPlace!{
                    showPlace(place: data.listOfPlaces[0])
                }else{
                    showPlace(place: data.listOfPlaces[currentIndexOfPlace!])
                }
            }
        }
    }
    func goBackward(){
        if data.listOfPlaces.count == 0{
            print("List is empty")
        }else{
            if contains(place: currentPlace){
                if currentIndexOfPlace! - 1 < 0{
                    showPlace(place: data.listOfPlaces[data.listOfPlaces.count-1])
                }else{
                    showPlace(place: data.listOfPlaces[currentIndexOfPlace!-1])
                }
            }
        }
    }
    
    func contains(place: AnnotationOfPlace) -> Bool{
        var contains = false
        for _place in data.listOfPlaces{
            if _place.coordinateOfPlace.latitude == place.coordinateOfPlace.latitude && _place.coordinateOfPlace.longitude == place.coordinateOfPlace.longitude{
                contains = true
                break
            }
        }
        return contains
    }
    
    func getIndex(place: AnnotationOfPlace) -> Int{
        var currentIndex = 0
        for place in data.listOfPlaces{
            if place.coordinateOfPlace.latitude == currentPlace.coordinateOfPlace.latitude{
                break
            }
            currentIndex += 1
        }
        return currentIndex
    }
    
    func addToCore(place: AnnotationOfPlace){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let myPlace = CustomPlace(context: context)
        myPlace.title = place.nameOfPlace
        myPlace.subtitle = place.titleOfPlace
        myPlace.latitude = String(place.coordinateOfPlace.latitude)
        myPlace.longitude = String(place.coordinateOfPlace.longitude)
        places.append(myPlace)
        appDelegate.saveContext()
    }
    
    func addAnnotation(place: AnnotationOfPlace){
        let annotation = MKPointAnnotation()
        annotation.title = place.nameOfPlace
        annotation.subtitle = place.titleOfPlace
        annotation.coordinate = place.coordinateOfPlace
        self.mapView.addAnnotation(annotation)
    }
    
    func deleteFromCore(atIndex: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(places[atIndex])
        places.remove(at: atIndex)
        appDelegate.saveContext()
    }
    
    func getData() -> [CustomPlace]{
        mapView.removeAnnotations(mapView.annotations)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do{
           places = try context.fetch(CustomPlace.fetchRequest())
        }catch{
            print("Error")
        }
        var list: [AnnotationOfPlace] = Array()
        for place in places{
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(place.latitude!)!, longitude: CLLocationDegrees(place.longitude!)!)
            let annotation = AnnotationOfPlace(name: place.title!, title: place.subtitle!, coordinate: coordinate)
            list.append(annotation)
            addAnnotation(place: annotation)
        }
        data.listOfPlaces = list
        return places
    }


}

