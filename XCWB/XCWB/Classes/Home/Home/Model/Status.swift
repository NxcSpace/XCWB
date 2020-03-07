//
//  Status.swift
//  XCWB
//
//  Created by nxc on 2020/3/7.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class Status: NSObject {
    // MARK:- 属性
    /// 微博创建时间
    @objc var created_at : String?
    
    /// 微博来源
    @objc var source : String? 
    
    /// 微博的正文
    @objc var text : String?
    
    /// 微博的ID
    @objc var mid : Int = 0
    
    ///用户信息
    @objc var user : User?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
        if let userDict = dict["user"] as? [String : Any] {
            user = User(dict: userDict)
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
