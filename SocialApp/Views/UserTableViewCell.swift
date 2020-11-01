//
//  UserTableViewCell.swift
//  SocialApp
//
//  Created by Asal 3 on 26/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    var random = false
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    
    var user: User? {
      didSet {
        guard let user = user else { return }
    
        userCompany.text = random.randomize ? user.company.name + user.company.bs : ""
        userName.text = user.username
        userEmail.text = user.email
      }
    }
    
}
extension Bool {
    var randomize: Bool {
        let randomBool = Bool.random()
        return randomBool

    }

}
