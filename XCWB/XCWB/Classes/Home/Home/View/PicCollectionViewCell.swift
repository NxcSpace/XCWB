//
//  PicCollectionViewCell.swift
//  XCWB
//
//  Created by nxc on 2020/3/8.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class PicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var picImageView: UIImageView!
    
    var picUrl : URL?{
        didSet {
            picImageView.sd_setImage(with: picUrl, placeholderImage: UIImage(named: "empty_picture"), options: [], completed: nil)
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
