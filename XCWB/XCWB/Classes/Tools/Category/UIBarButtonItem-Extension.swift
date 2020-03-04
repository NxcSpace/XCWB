//
//  UIBarButtonItem-Extension.swift
//  XCWB
//
//  Created by nxc on 2020/3/4.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageNamed: String) {
        let btn = UIButton(imageForH: "imageNamed")
        self.init(customView:btn)
        
    }
    
}
