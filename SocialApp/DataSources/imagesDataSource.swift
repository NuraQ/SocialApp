//
//  imagesDataSource.swift
//  SocialApp
//
//  Created by Asal 3 on 26/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ImagesDataSource: NSObject {

var images:[UIImage] = []
    let headers: HTTPHeaders = [
               .authorization(username: "test@email.com", password: "testpassword"),
               .accept("application/json")
           ]
    
    override init() {
        super.init()
//        for _ in 0..<5{
//            images.append(#imageLiteral(resourceName: "Unknown"))
//        }
   fetchData()
            
              }
    
    func fetchData () {
        AF.request("https://jsonplaceholder.typicode.com/albums/1/photos",method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
           // print(response)
       switch response.result {
                       case .success(let value):
                      //  let t = try? JSONSerialization.data(withJSONObject: value)
                        if let jsonArray = value as? [[String: Any]] {
                            for dic in jsonArray{
                          //      guard let url = dic["url"] as? URLConvertible else { return }
                                AF.request(dic["url"] as! String,method: .get, encoding: JSONEncoding.default).responseData { response in
                                    print(response.result)
                                    if let data = response.value {
                                        guard let img = UIImage(data: data) else { return }
                                        self.images.append(img)
                                        
                                    }                            }
                            }

                           }
                       case .failure(let error):
                           print(error)
                       }


    }

}

}

