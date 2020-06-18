//
//  MapViewController.swift
//  Hills
//
//  Created by nitesh.banskota on 2/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit
import  MapKit
import CoreLocation
import DropDown


class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var selectStateButton: UIButton!
    @IBOutlet weak var selectCityButton: UIButton!
    @IBOutlet weak var getDetailButton: UIButton!
    let manager = CLLocationManager()
    
    var branch: BranchDetail?
    let stateDropDown = DropDown()
    let cityDropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        stateDropDown.anchorView = selectStateButton
        cityDropDown.anchorView = selectCityButton
        stateDropDown.dataSource = Constants.Map.state
        selectCityButton.isHidden = true
        getDetailButton.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    @IBAction func stateButtonPressed(_ sender: UIButton) {
        stateDropDown.show()
        stateDropDown.selectionAction = {
            [unowned self](index: Int, item: String) in
            self.selectStateButton.setTitle(item, for: [])
            self.selectCityButton.isHidden = false
            self.cityDropDown.dataSource = Constants.Map.Cities.getCity(item)
            self.cityDropDown.show()
            self.cityDropDown.selectionAction = {
            [unowned self](index: Int, item: String) in
            self.selectCityButton.setTitle(item, for: [])
                let (location, branch) = Constants.Map.Cities.pinLocation(item)
                self.pinPointLocation(location: location)
                self.getDetailButton.isHidden = false
                self.branch = branch
            }
        }
        
        
    }
    
    @IBAction func cityButtonPressed(_ sender: UIButton) {
    self.cityDropDown.show()
    self.cityDropDown.selectionAction = {
    [unowned self](index: Int, item: String) in
    self.selectCityButton.setTitle(item, for: [])
         let (location, branch) = Constants.Map.Cities.pinLocation(item)
             self.pinPointLocation(location: location)
        
        self.branch = branch
    }
    }
    
    @IBAction func getDetailButtonPressed(_ sender: UIButton) {
     performSegue(withIdentifier: "branchDetail", sender: self)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        
    }

    @IBAction func myLocationPressed(_ sender: UIButton) {
        manager.startUpdatingLocation()
    }
    
    func pinPointLocation(location: CLLocationCoordinate2D) -> Void {
        let placeCoordinate = location
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: placeCoordinate, span: span)
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = placeCoordinate
        mapView.addAnnotation(pin)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "branchDetail"{
            let destinationVC = segue.destination as! BranchInfoViewController
            destinationVC.branchInfo = branch
        }
    }
}
