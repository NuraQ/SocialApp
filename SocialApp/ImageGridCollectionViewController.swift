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
    var imagesDataSource = ImagesDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let cellNib = UINib(nibName: "GridCollectionViewCell", bundle: nil)
        self.collectionView!.register(cellNib, forCellWithReuseIdentifier: "GridCollectionViewCell")

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return imagesDataSource.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "grid", for: indexPath)
       let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "GridCollectionViewCell" , for: indexPath
        ) as? GridCollectionViewCell ?? Bundle.main.loadNibNamed("GridCollectionViewCell", owner: self,options: nil)?.first as! GridCollectionViewCell
        
        
        // Configure the cell
        cell.gridImage?.image = imagesDataSource.images[indexPath.row]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath as IndexPath, animated: true)
        selectedRow = indexPath.row
        performSegue(withIdentifier: "imageView", sender: self)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
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
            let indexPathh = selectedRow
             let selectedImage = imagesDataSource.images[indexPathh]
            imageScene.img = selectedImage
         }
     }

}
