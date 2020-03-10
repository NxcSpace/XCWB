//
//  EmoticonTextAttachment.swift
//  EmojiKeyBordDemo
//
//  Created by nxc on 2020/3/10.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class EmoticonTextAttachment: NSTextAttachment {
    var chs:String = ""
    init() {
        super.init(data: nil, ofType: nil)
//        super.init(image: UIImage(named: "")!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
