//
//  SecondViewController.swift
//  MIXR
//
//  Created by Brendan Winter on 10/2/15.
//  Copyright (c) 2015 MIXR LLC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Mapbox
import MapKit

class MapViewController: BaseViewController, MGLMapViewDelegate {
    
    @IBOutlet var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMapData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMapData() {
        
        let URL =  globalConstants.kAPIURL + globalConstants.kVenueCoordinatesAPIEndPoint
        
        Alamofire.request(.GET, URL , encoding: .JSON)
            .responseJSON { response in
                guard let value = response.result.value else {
                    print("Error: did not receive data")
                    return
                }
                
                guard response.result.error == nil else {
                    print("error calling POST")
                    print(response.result.error)
                    return
                }
                
                
                let json = JSON(response.result.value!)
                
                for (index,subJson):(String, JSON) in json {
                    print(index)
                    print(subJson)
                    
                    let name = subJson["name"].stringValue
                    let address = subJson["location"]["address"].stringValue
                    let longitude = subJson["location"]["longitude"].stringValue
                    let latitude = subJson["location"]["latitude"].stringValue
                    let coordinate = CLLocationCoordinate2D(latitude: (latitude as NSString).doubleValue, longitude: (longitude as NSString).doubleValue)
                    
                    let point = MGLPointAnnotation()
                    point.coordinate = coordinate
                    point.title = name
                    point.subtitle = address
                    
                    self.mapView.addAnnotation(point)
                }
                
                print("Response String:")
        }
    }
    
    func mapView(mapView: MGLMapView, rightCalloutAccessoryViewForAnnotation annotation: MGLAnnotation) -> UIView? {
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 60, 50)
        button.backgroundColor = UIColor.whiteColor()
        button.setTitle("View", forState: UIControlState.Normal)
        button.titleLabel?.textColor = UIColor.redColor()
        button.targetForAction(Selector("buttonAction"), withSender:self )
        
        return button
 
    }
  
    func mapView(mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        // hide the callout view
        mapView.deselectAnnotation(annotation, animated: false)
        
        let title = annotation.title!!
        
        //PUSH TO VENUE PROFILE use TITLE AS ID
        
        
        //potentially dangerous if multiple bars named identically
        //saves from inheriting MGLAnnotation, adding a venue_id string, extending the MGLMapViewDelegate with passing the VenueAnnotation (custom class with string) to this function annotation: VenueAnnotation. problem is that Mapbox is in Objective C so extending the protocol requires bridging header but the Swift VenueAnnotation object won't import in the extened protocol class nor could I import the extended protocol class
        
        UIAlertView(title: "\(annotation.title!!)", message: "A lovely \(title) bar!", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK").show()
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    
}

