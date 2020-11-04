//
//  HeaderCollectionView.swift
//  SocialApp
//
//  Created by Asal 3 on 04/11/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    
    
    func setHeadertext(header: String) {
        headerLabel.text = header
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
