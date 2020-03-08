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
    
    ///配图信息
    @objc var pic_urls : [[String : String]]?
    
    ///转发微博
    @objc var retweeted_status : Status?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
        if let userDict = dict["user"] as? [String : Any] {
            user = User(dict: userDict)
        }
        
        if let retweetedDict = dict["retweeted_status"] as? [String : Any] {
            retweeted_status = Status(dict: retweetedDict)
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
