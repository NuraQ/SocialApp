//
//  DetailsViewController.swift
//  SocialApp
//
//  Created by Asal 3 on 26/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit
import MapKit
class DetailsViewController: UIViewController , UIScrollViewDelegate{
    
    
    @IBOutlet weak var useName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var webSite: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var userImage: UIImageView! {
        didSet{
            userImage.image = #imageLiteral(resourceName: "scott")
        }
    }
    
  
    
    let MapView: MKMapView = {
        let map = MKMapView()
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        map.isUserInteractionEnabled = false
        return map
        
    }()
    @IBOutlet weak var contentView: UIView!
    
    //phoneNumber.is = true
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeImgCircular()
        
       
    }
    var user:User? {
        didSet{
            guard user != nil else { return }
        }
    }
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateLabels()
        setUpMap()
        self.setupLabelTap()
        
    }
    
    func makeImgCircular(){
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 3;
        userImage.layer.borderColor =  #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        userImage.layer.cornerRadius = userImage.frame.size.width / 2.0 ;
    }
    
    func setUpMap() {
        let latitude = ((user?.address.geo.lat ?? "-41.9") as NSString).doubleValue
        let longitude = ((user?.address.geo.lng ?? "-150.0") as NSString).doubleValue
        let userLocation = CLLocation(latitude:latitude,  longitude:   longitude);
        mapView.centerToLocation(userLocation)
        let locationStr = user?.address.city ?? "" + " , " +  (user?.address.street ?? "")
        mapView.setUpMarker(latitude: latitude, long: longitude,
                            address: locationStr      )
    }
    
    func updateLabels() {
        
        let strLocation = "city" + (user?.address.city)! + "  street: " +  (user?.address.street)!
        useName?.text = (user?.username)!
        Email?.text = (user?.email)!
        phoneNumber?.text = (user?.phone)!
        webSite?.text = (user?.website)!
        location?.text = strLocation 
        company?.text = "Company: " + (user?.company.name)! + (user?.company.catchPhrase)! + (user?.company.bs)!

    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        //  let email = "nura.qasrawi@gmail.com"
        //   if let url = URL(string: "mailto://\(email)") {
        if let url = URL(string: "tel://1800900900") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(url)) {
                application.open(url , options: [:], completionHandler: nil)
            }
        }
    }
    
    func setupLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        self.phoneNumber.isUserInteractionEnabled = true
        self.phoneNumber.addGestureRecognizer(labelTap)
    }
}

extension MKMapView {
    
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MKMapView {
    func setUpMarker(latitude: Double, long: Double, address:String) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude:CLLocationDegrees(long))
        annotation.coordinate = centerCoordinate
        annotation.title = address
        self.addAnnotation(annotation)
    }
    
}


