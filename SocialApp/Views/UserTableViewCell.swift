//
//  UserTableViewCell.swift
//  SocialApp
//
//  Created by Asal 3 on 26/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!

    var user: User? {
      didSet {
        guard let user = user else { return }
    
        userName.text = user.userName
        userEmail.text = user.email
      }
    }
    
}
