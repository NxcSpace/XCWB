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
    
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    
    @IBOutlet weak var picCollectionView: UICollectionView!
    
    @IBOutlet weak var reContentLabel: UILabel!
    
    @IBOutlet weak var reTwBackView: UIView!
    var userModel: UserViewModel?{
        didSet{
            guard let user = userModel else {
                return
            }
            
            headerView.sd_setImage(with: user.profileImageUrl, placeholderImage: UIImage(named: "avatar_default_small"))
            nameLabel.text = user.status?.user?.screen_name
            vipView.image = user.verifiedImage
            iconView.image = user.vipImage
            contentLabel.attributedText = FindEmoticon.emoticon.findEmojiReplaceAttrStr(str: user.status?.text, font: contentLabel.font)
            timeLabel.text = user.createAtText
            sourceLabel.text = user.sourceText
            
            nameLabel.textColor = user.vipImage == nil ? UIColor.black : UIColor.orange
            
            if user.reContentText != "" {
                reContentLabel.text = user.reContentText
                reTwBackView.isHidden = false
            }else {
                reContentLabel.text = ""
                reTwBackView.isHidden = true
            }
            
            let size = getPicViewSize(count: user.picUrls.count)
            picViewWCons.constant = size.width
            picViewHCons.constant = size.height
            picCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        picCollectionView.delegate = self
        picCollectionView.dataSource = self
        picCollectionView.register(UINib.init(nibName: "PicCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PicCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeViewCell
{
    // MARK: - 计算UICollectionView高度
    private func getPicViewSize(count: Int) -> CGSize {
        if count == 0 {
            return CGSize.zero
        }
        let edgeM: CGFloat = 10.0
        let layout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = edgeM
        layout.minimumLineSpacing = edgeM
        
        if count == 1 {
            let url = userModel?.picUrls.last?.absoluteString
            let image = SDImageCache.shared.imageFromDiskCache(forKey: url)
            guard let imageOne = image else {
                return CGSize.zero
            }
            
            layout.itemSize = CGSize.init(width: imageOne.size.width * 2, height: imageOne.size.height * 2)
            layout.minimumInteritemSpacing = 0.0
            layout.minimumLineSpacing = 0.0
            return layout.itemSize
        }
        
        if count == 4 {
            let itemWH = (UIScreen.main.bounds.width - 15 * 2 - edgeM * 1) / 2
            
            let rows = 2
            
            let picH = CGFloat(rows) * itemWH + CGFloat(rows - 1) * edgeM
            
            let picW = UIScreen.main.bounds.width - 15 * 2
            layout.itemSize = CGSize.init(width: itemWH, height: itemWH)
            return CGSize.init(width: picW, height: picH)
        }else if count > 0 {
            let itemWH = (UIScreen.main.bounds.width - 15 * 2 - edgeM * 2) / 3
            
            let rows = (count - 1) / 3 + 1
            
            let picH = CGFloat(rows) * itemWH + CGFloat(rows - 1) * edgeM
            
            let picW = UIScreen.main.bounds.width - 15 * 2
            layout.itemSize = CGSize.init(width: itemWH, height: itemWH)
            return CGSize.init(width: picW, height: picH)
        }
        
        layout.itemSize = CGSize.zero
        return CGSize.zero
    }
}
// MARK: - UICollectionViewDataSource && UICollectionViewDelegate
extension HomeViewCell : UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userModel?.picUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCollectionViewCell", for: indexPath) as! PicCollectionViewCell
        cell.picUrl = userModel?.picUrls[indexPath.row]
        return cell
        
    }
    
    
    
}
