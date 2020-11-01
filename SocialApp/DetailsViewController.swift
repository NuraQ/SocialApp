//
//  DetailsViewController.swift
//  SocialApp
//
//  Created by Asal 3 on 26/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var useName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var webSite: UILabel!
    @IBOutlet weak var userImage: UIImageView! {
        didSet{
            var img = #imageLiteral(resourceName: "scott")
            userImage.image = #imageLiteral(resourceName: "scott")
            
        }
    }
    //phoneNumber.is = true
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //
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
        }
    }
    
    override func viewDidLoad() {
        phoneNumber.isUserInteractionEnabled = true
        self.setupLabelTap()

        useName?.text = "Name: " + (user?.username)!
        Email?.text = "Email:  " + (user?.email)!
        phoneNumber?.text = "PhoneNumber:  " + (user?.phone)!
        webSite?.text = "Website:  " + (user?.website)!
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
          let email = "foo@bar.com"
        if let url = URL(string: "mailto:\(email)") {

          let application:UIApplication = UIApplication.shared
          if (application.canOpenURL(url)) {
            application.open(url, options: [:], completionHandler: nil)
          }
        }
    
        
    }
    
    func setupLabelTap() {
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        self.phoneNumber.isUserInteractionEnabled = true
        self.phoneNumber.addGestureRecognizer(labelTap)
        
    }
}
