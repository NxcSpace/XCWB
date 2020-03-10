//
//  EmoticonPackage.swift
//  EmojiKeyBordDemo
//
//  Created by nxc on 2020/3/9.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class EmoticonPackage {
    var array = [Emoticn]()
    
    init(id: String) {
        let bundlePath = Bundle.main.path(forResource: "Emoticons", ofType: "bundle", inDirectory: nil)!
        
       let path =  bundlePath + "/\(id)/info.plist"
       
       
        guard let arr = NSArray(contentsOfFile: path) else {
            addEmptyItem()
            return
        }
        
        var index = 0
        
        for dict in arr {
            if index % 21 == 20 {
                array.append(Emoticn(isDelete: true))
                index += 1
            }
            let icon = Emoticn(dict: dict as! [String : String])
            if icon.png != "",icon.png != nil {
                icon.iconPath = bundlePath + "/\(id)/\(icon.png!)"
            }
            array.append(icon)
            index += 1
        }
        
        addEmptyItem()
    }
    
    func addEmptyItem() {
        let emptyCount = 21 - (array.count % 21)
        
        if emptyCount != 0 {
            for idx in 0 ..< emptyCount {
                
                if idx == emptyCount - 1 {
                    array.append(Emoticn(isDelete: true))
                }else {
                    array.append(Emoticn(isEmpty: true))
                }
            }
        }
    }
}
