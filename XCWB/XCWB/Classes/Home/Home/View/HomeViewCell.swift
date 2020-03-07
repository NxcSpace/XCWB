//
//  HomeViewCell.swift
//  XCWB
//
//  Created by nxc on 2020/3/7.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit
import SDWebImage
class HomeViewCell: UITableViewCell {
    @IBOutlet weak var headerView: UIImageView!
    
    @IBOutlet weak var vipView: UIImageView!
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var userModel: UserViewModel?{
        didSet{
            guard let user = userModel else {
                return
            }
            
            headerView.sd_setImage(with: user.profileImageUrl, placeholderImage: UIImage(named: "avatar_default_small"))
            nameLabel.text = user.status?.user?.screen_name
            vipView.image = user.verifiedImage
            iconView.image = user.vipImage
            contentLabel.text = user.status?.text
            timeLabel.text = user.createAtText
            sourceLabel.text = user.sourceText
            
            nameLabel.textColor = user.vipImage == nil ? UIColor.black : UIColor.orange
            
        
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
