//
//  ComposeTitleView.swift
//  XCWB
//
//  Created by nxc on 2020/3/8.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTitleView: UIView {
    
    private lazy var titleLabel : UILabel = UILabel()
    private lazy var screenNameLabel : UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI界面
extension ComposeTitleView {
    private func setupUI() {
        // 1.将子控件添加到view中
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        // 2.设置frame
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        
        screenNameLabel.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(titleLabel.center.x)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        // 3.设置空间的属性
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        screenNameLabel.font = UIFont.systemFont(ofSize: 14)
        screenNameLabel.textColor = UIColor.lightGray
        
        // 4.设置文字内容
        titleLabel.text = "发微博"
        screenNameLabel.text = UserAccountViewModal.shareIntance.userInfo?.screen_name
    }
}
