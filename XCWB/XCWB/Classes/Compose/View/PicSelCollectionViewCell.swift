//
//  PicSelCollectionViewCell.swift
//  XCWB
//
//  Created by nxc on 2020/3/9.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class PicSelCollectionViewCell: UICollectionViewCell {
    
    var image: UIImage?{
        didSet{
            if image == nil {
                addButton.setBackgroundImage(UIImage(named: "compose_pic_add_highlighted"), for: .normal)
                delButton.isHidden = true
                addButton.isUserInteractionEnabled = true
            }else {
                addButton.isUserInteractionEnabled = false
                delButton.isHidden = false
                addButton.setBackgroundImage(image, for: .normal)
            }
        }
    }
    
    @IBOutlet weak var delButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func selectPicAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ModalPicSelectPickerNotifiction), object: nil);
    }
    @IBAction func deleteAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DeletePicSelectPickerNotifiction), object: image);
    }
    

}
