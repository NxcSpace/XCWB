//
//  Emoticn.swift
//  EmojiKeyBordDemo
//
//  Created by nxc on 2020/3/9.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class Emoticn: NSObject {
    @objc var png: String?
    @objc var chs: String?
    @objc var cht: String?
    @objc var code: String?{
        didSet{
            guard let emoCode = code else {
                return
            }
            
            let scanner = Scanner(string: emoCode)
            var p : uint = 0

            scanner.scanHexInt32(&p)
            
            guard let c = Unicode.Scalar(p) else {
                return
            }
            
            emojiStr = String(Character(c))
            
        }
    }
    @objc var type: String?
    //全路径
    @objc var iconPath: String?
    @objc var emojiStr: String?
    @objc var deleteFlag: Bool = false
    @objc var emptyFlag: Bool = false
    
    init(dict: [String:String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    init(isDelete: Bool) {
        super.init()
        deleteFlag = isDelete
    }
    
    init(isEmpty: Bool) {
        super.init()
        emptyFlag = isEmpty
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
       
        return dictionaryWithValues(forKeys: ["iconPath","emojiStr","chs","deleteFlag","emptyFlag"]).description
    }
}
