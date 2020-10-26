//
//  imagesDataSource.swift
//  SocialApp
//
//  Created by Asal 3 on 26/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit
import Foundation
class ImagesDataSource: NSObject {

var images:[UIImage] = []
    
    
    override init() {
        for _ in 0..<5{
            images.append(#imageLiteral(resourceName: "Unknown"))
        }
    }

}
