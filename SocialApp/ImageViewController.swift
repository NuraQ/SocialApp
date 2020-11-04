//
//  ImageViewController.swift
//  SocialApp
//
//  Created by Asal 3 on 27/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController , UIGestureRecognizerDelegate {

    @IBOutlet weak var image: UIImageView! {
        didSet {
            image?.image = img
        }
    }
    
    var tabBarState = true
    var img:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadInputViews()
       image?.image = img
        
        let tapGesture = UITapGestureRecognizer(target: self,
        action: #selector(onTap(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)

    }
    
   @objc func onTap(_ gesture: UIGestureRecognizer) {
      if (gesture.state == .ended) {
        /* action */
        self.tabBarController?.tabBar.isHidden = toggleTabBar()
      }
    }
    
    func toggleTabBar() -> Bool {
        tabBarState = !tabBarState
        return tabBarState
    }
   

}
