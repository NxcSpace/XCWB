//
//  UserAccount.swift
//  XCWB
//
//  Created by nxc on 2020/3/6.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(access_token, forKey: "access_token")
        coder.encode(expires_date, forKey: "expires_date")
        coder.encode(uid, forKey: "uid")
        coder.encode(screen_name, forKey: "screen_name")
        coder.encode(avatar_large, forKey: "avatar_large")
    }
    
    required init?(coder: NSCoder) {
        access_token = coder.decodeObject(forKey: "access_token") as? String
        expires_date = coder.decodeObject(forKey: "expires_date") as? NSDate
        uid = coder.decodeObject(forKey: "uid") as? String
        screen_name = coder.decodeObject(forKey: "screen_name") as? String
        avatar_large = coder.decodeObject(forKey: "avatar_large") as? String

    }
    
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
        return dictionaryWithValues(forKeys: ["access_token","expires_date","screen_name","avatar_large","uid"]).description
    }
    
}
