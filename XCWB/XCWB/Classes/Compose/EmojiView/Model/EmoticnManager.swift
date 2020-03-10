//
//  EmoticnManager.swift
//  EmojiKeyBordDemo
//
//  Created by nxc on 2020/3/10.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class EmoticnManager {
    var packageArr = [EmoticonPackage]()
    
    init() {
       
        packageArr.append(EmoticonPackage(id:""))
        packageArr.append(EmoticonPackage(id:"com.sina.default"))
        packageArr.append(EmoticonPackage(id:"com.apple.emoji"))
        packageArr.append(EmoticonPackage(id:"com.sina.lxh"))
        
    }
}
