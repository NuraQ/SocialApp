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
        
        let tapGesture = UITapGestureRecognizer(target: self,
        action: #selector(onTap(_:)))
        image.addGestureRecognizer(tapGesture)

    }
    
   @objc func onTap(_ gesture: UIGestureRecognizer) {
      if (gesture.state == .ended) {
        /* action */
        print("sdefw")
      }
    }
   

}
