//
//  DetailsViewController.swift
//  SocialApp
//
//  Created by Asal 3 on 26/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit
import MapKit
class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var useName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var webSite: UILabel!
    @IBOutlet weak var location: UILabel!
@IBOutlet private var mapView: MKMapView!
    @IBOutlet weak var userImage: UIImageView! {
        didSet{
            var img = #imageLiteral(resourceName: "scott")
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

    //phoneNumber.is = true
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 3;
        userImage.layer.borderColor =  UIColor.lightGray.cgColor
        userImage.layer.cornerRadius = userImage.frame.size.width / 2.0 ;
    }
    var user:User? {
        didSet{
            guard let user = user else { return }
        

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        self.setupLabelTap()
        updateLabels()

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func setUpMap() {
        let latitude = ((user?.address.geo.lat ?? "-41.9") as NSString).doubleValue
        let longitude = ((user?.address.geo.lng ?? "-150.0") as NSString).doubleValue
        let userLocation = CLLocation(latitude:latitude,  longitude:   longitude);
        var strLocation = (user?.address.city)! + "," + (user?.address.street)!

        mapView.centerToLocation(userLocation)
        mapView.setUpMarker(latitude: latitude, long: longitude,
                            address: strLocation  )
    }
    
    func updateLabels() {
        useName?.text = "Name: " + (user?.username)!
        Email?.text = "Email:  " + (user?.email)!
        phoneNumber?.text = "PhoneNumber:  " + (user?.phone)!
        webSite?.text = "Website:  " + (user?.website)!
        location?.text = "address: " + (user?.address.city)! + "," + (user?.address.street)!
    }
  
 
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
          let email = "nura.qasrawi@gmail.com"
     //   if let url = URL(string: "mailto://\(email)") {
        if let url = URL(string: "tel://1800900900") {

          let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(url)) {
                application.open(url , options: [:], completionHandler: nil)
          }
        }
//        if MFMailComposeViewController.canSendMail() {
//               let mail = MFMailComposeViewController()
//               mail.mailComposeDelegate = self
//               mail.setToRecipients(["you@yoursite.com"])
//               mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
//
//               present(mail, animated: true)
//           } else {
//               // show failure alert
//           }
    
        
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
