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
    
    
    var galleries = [Int: [Image]]()
    var imgs:[Image] = []
    
    init(collectionImgs: UICollectionView) {
        super.init()
        fetchImages(collectionImgs: collectionImgs)
    }
    
    
    func fetchImages (collectionImgs: UICollectionView) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 200
        
        AF.request("https://jsonplaceholder.typicode.com/photos",method: .get, parameters:nil, encoding: JSONEncoding.default).responseJSON { response in
            
            if let data = response.data {
                if let decodedResponse = try? JSONDecoder().decode([Image].self, from: data) {
                    self.imgs = decodedResponse
                    self.imgsSort()
                    DispatchQueue.main.async{
                        collectionImgs.reloadData()
                    }
                }
            }
        }
        
    }
    
    //sorts images based on albumID , uses dictionary to do that
    func imgsSort() {
        var gallery:[Image] = []
        for img in imgs {
            galleries[img.albumId]  = galleries[img.albumId] ?? []
            gallery.append(img)
            galleries[img.albumId] = gallery
        }
    }
}




