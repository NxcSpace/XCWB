//
//  UserAccount.swift
//  XCWB
//
//  Created by nxc on 2020/3/6.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    ///授权token
    @objc var access_token: String?
    ///过期时间
    @objc var expires_in: TimeInterval = 0{
        didSet{
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    //用户id
    @objc var uid: String?
    
    @objc var expires_date: NSDate?
    
    @objc var screen_name: String?
    
    @objc var avatar_large: String?
    init(dict: [String: Any]) {
        super.init()

        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["access_token","expires_date","screen_name","avatar_large"]).description
    }
    
}
