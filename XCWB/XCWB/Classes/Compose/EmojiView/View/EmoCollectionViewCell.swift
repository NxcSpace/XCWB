//
//  EmoCollectionViewCell.swift
//  EmojiKeyBordDemo
//
//  Created by nxc on 2020/3/10.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class EmoCollectionViewCell: UICollectionViewCell {
    lazy var emoButton = UIButton(type: .custom)
    var emoModel : Emoticn?{
        didSet{
            guard let model = emoModel else {
                return
            }
            
            emoButton.setTitle(model.emojiStr, for: .normal)
            emoButton.setImage(UIImage(named: model.iconPath ?? ""), for: .normal)
            
            if model.deleteFlag {
                emoButton.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(emoButton)
        emoButton.frame = contentView.bounds
        emoButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        emoButton.isUserInteractionEnabled = false
    }
    
}
