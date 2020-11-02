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

struct Image: Codable {
    public let id: Int
    public let albumId: Int
    public let url: String

}
class ImagesDataSource: NSObject {
    
    var images:[UIImage] = []
    var galleries = [Int: [Image]]()
    var fetchedImages = [Int: [UIImage]]()

    var imgs:[Image] = []
    
    init(collectionImgs: UICollectionView) {
        super.init()
        fetchImages(collectionImgs: collectionImgs)
        
    }
    
    //    if let data = try? Data(contentsOf: url!)
    //       {
    //         let image: UIImage = UIImage(data: data)
    //       }
    
    func fetchImages (collectionImgs: UICollectionView) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 200
        
        AF.request("https://jsonplaceholder.typicode.com/photos",method: .get, parameters:nil, encoding: JSONEncoding.default).responseJSON { response in
            
            if let data = response.data {
                
                if let decodedResponse = try? JSONDecoder().decode([Image].self, from: data) {
                    self.imgs = decodedResponse
                    imgsSort()
                    DispatchQueue.main.async{
                        
                        collectionImgs.reloadData()
                    }
                    // imgsSort()
                }
                // everything is good, so we can exit
            }
            // self.imgsSort()
            
            
        }
        
        
        
        func imgsSort() {
            var gallery:[Image] = []
            
            for img in imgs {
                galleries[img.albumId]  = galleries[img.albumId] ?? []
                gallery.append(img)
                galleries[img.albumId] = gallery
            }
            
        }
        // print( galleries[2]!)
        print("yea")
        
    }
    
    func appendToFetchedImgs(indexPath: IndexPath, img:UIImage) {
        var gallery:[UIImage] = []
        fetchedImages[indexPath.section]  = fetchedImages[indexPath.section] ?? []
        gallery.append(img)
        fetchedImages[indexPath.section] = gallery
    }
    

}
//func fetchData ()  -> UIImage {
//    var imgg:UIImage = #imageLiteral(resourceName: "Msn_messenger_logo")
//    //      guard let url = dic["url"] as? URLConvertible else { return }
//    AF.request("https://via.placeholder.com/600/24f355" ,method: .get, encoding: JSONEncoding.default).responseData { response in
//        //print(response.result)
//
//        if let data = response.value {
//
//            guard let img = UIImage(data: data) else { return }
//            imgg = img
//            self.images.append(img)
//
//
//
//        }
//
//    }
//    return imgg
//
//}



