//
//  UIButton-Extension.swift
//  XCWB
//
//  Created by nxc on 2020/3/3.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

extension UIButton{
    
    convenience init(image: String, backImage: String){
        self.init()
        self.setImage(UIImage(named: image), for: .normal)
        self.setImage(UIImage(named: image + "_highlighted"), for: .highlighted)
        self.setBackgroundImage(UIImage(named: backImage), for: .normal)
        self.setBackgroundImage(UIImage(named: backImage + "_highlighted"), for: .highlighted)
        self.sizeToFit()
    }
    
    convenience init(imageForH: String) {
        self.init()
        self.setImage(UIImage(named: imageForH), for: .normal)
        self.setImage(UIImage(named: imageForH + "_highlighted"), for: .highlighted)
        self.sizeToFit()
    }
}

