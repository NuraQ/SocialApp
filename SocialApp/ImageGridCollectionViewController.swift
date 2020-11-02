//
//  ImageGridCollectionViewController.swift
//  SocialApp
//
//  Created by Asal 3 on 26/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImageGridCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    private var selectedRow = 0
    private var selectedSection = 0
    
    var val = 0
    
    @IBOutlet var imageGridCollectionView: UICollectionView!
    lazy var imagesDataSource = ImagesDataSource(collectionImgs: self.imageGridCollectionView)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        collectionView.allowsMultipleSelection = false
        // Register cell classes
        let cellNib = UINib(nibName: "GridCollectionViewCell", bundle: nil)
        self.collectionView!.register(cellNib, forCellWithReuseIdentifier: "GridCollectionViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return imagesDataSource.galleries.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let sections = imagesDataSource.galleries.count
        for sectionNumber in 0..<sections {
            if sectionNumber == section {
                return imagesDataSource.galleries[sectionNumber]?.count ?? imagesDataSource.galleries.count
            }
        }
        return imagesDataSource.imgs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "grid", for: indexPath)
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "GridCollectionViewCell" , for: indexPath
            ) as? GridCollectionViewCell ?? Bundle.main.loadNibNamed("GridCollectionViewCell", owner: self,options: nil)?.first as! GridCollectionViewCell
        
        let x = imagesDataSource.galleries[indexPath.section + 1]
        //imagesDataSource.getImage(imageURL: "")
        if x?.indices.contains(indexPath.row) ?? false {
            if let url = URL(string: x?[indexPath.row].url ?? "" ) {
                
                DispatchQueue.global(qos: .background).async {
                    
                    if let data = try? Data(contentsOf: url)
                    {
                        let image: UIImage = UIImage(data: data)!
                        self.imagesDataSource.appendToFetchedImgs(indexPath: indexPath, img: image)
                      //  self.imagesDataSource.fetchedImages[indexPath.section + 1]?.append(image)
                        self.imagesDataSource.images.append(image)
                        DispatchQueue.main.sync {
                            cell.gridImage?.image = image
                            
                        }
                    }
                }
            }
        }
        // Configure the celli
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     //   collectionView.deselectItem(at: indexPath as IndexPath, animated: true)
        selectedRow = indexPath.row
        selectedSection = indexPath.section
        performSegue(withIdentifier: "imageView", sender: self)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageView" ,
            let imageScene = segue.destination as? ImageViewController {
        
            let selectedImageUrl = imagesDataSource.galleries[selectedSection + 1]?[selectedRow].url
            var selectedImage:UIImage = #imageLiteral(resourceName: "photo-gallery-icon_1948830")
            if let url = URL(string:selectedImageUrl ?? "" ) {
                
                    if let data = try? Data(contentsOf: url)
                    {
                        let image: UIImage = UIImage(data: data)!
                    
                        self.imagesDataSource.images.append(image)
                         //imageScene.img = image
                        imageScene.img = image
                    }

                
            }
            print(selectedRow)
        }
    }
    
}
