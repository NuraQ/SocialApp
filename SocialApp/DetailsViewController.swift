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
    
    var user:User? {
        didSet{
            guard let user = user else { return }
            
                useName?.text = user.userName
                Email?.text = user.email
                phoneNumber?.text = user.phoneNumber
                webSite?.text = user.webSite!
        }
    }
    override func viewDidLoad() {
        useName?.text = user?.userName
        Email?.text = user?.email
        phoneNumber?.text = user?.phoneNumber
        webSite?.text = user?.webSite!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
