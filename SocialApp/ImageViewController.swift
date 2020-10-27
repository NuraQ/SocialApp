//
//  ImageViewController.swift
//  SocialApp
//
//  Created by Asal 3 on 27/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var image: UIImageView! {
        didSet {
            image?.image = img
        }
    }
    
    var img:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadInputViews()
       image?.image = img
      //  print(image)
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
