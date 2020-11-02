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
            
            useName?.text = "Name: " + user.username
            Email?.text = "Email" + user.email
            phoneNumber?.text = "Phone Number" + user.phone
            webSite?.text = "website: " + user.website
            location?.text = "addreaa: " + user.address.city

        }
    }
    
    override func viewDidLoad() {
        // Set initial location in Honolulu
        
       // let userLocation = CLLocation(latitude: user?.address.geo.lat ?? 21.4765, longitude: user?.address.geo.lng ?? -157.9647);
       // mapView.centerToLocation(userLocation)
        phoneNumber.isUserInteractionEnabled = true
        location.isUserInteractionEnabled = true

        self.setupLabelTap()

        useName?.text = "Name: " + (user?.username)!
        Email?.text = "Email:  " + (user?.email)!
        phoneNumber?.text = "PhoneNumber:  " + (user?.phone)!
        webSite?.text = "Website:  " + (user?.website)!
        location?.text = "addreaa: " + (user?.address.city)!
        
        

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
   
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
    
        @objc func mapTapped(_ sender: UITapGestureRecognizer) {
           if let url = URL(string: "http://maps.apple.com/maps?saddr=\(user?.address.geo.lat)&daddr=\(user?.address.geo.lng)")
           {
            let application:UIApplication = UIApplication.shared
                       if (application.canOpenURL(url)) {
                           application.open(url , options: [:], completionHandler: nil)
                     }
            }
            
        }
    func setupLabelTap() {
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        let map = UITapGestureRecognizer(target: self, action: #selector(self.mapTapped(_:)))

        self.phoneNumber.isUserInteractionEnabled = true
        self.phoneNumber.addGestureRecognizer(labelTap)
        self.location.isUserInteractionEnabled = true
        self.location.addGestureRecognizer(map)

        
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
