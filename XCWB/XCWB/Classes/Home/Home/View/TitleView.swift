//
//  TitleView.swift
//  XCWB
//
//  Created by nxc on 2020/3/4.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class TitleView: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let titleL = self.titleLabel!
        let image = self.imageView!
        
        titleL.frame.origin.x = 0
        image.frame.origin.x = titleL.frame.size.width + 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
