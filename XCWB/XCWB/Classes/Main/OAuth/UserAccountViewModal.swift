//
//  UserAccountViewModal.swift
//  XCWB
//
//  Created by nxc on 2020/3/7.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class UserAccountViewModal {
    ///单例
    static let shareIntance: UserAccountViewModal = UserAccountViewModal()
    ///用户信息
    var userInfo: UserAccount?
    
    ///用户信息存储路径
    var path: String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        return (path as NSString).appendingPathComponent("user.plist")
    }
    
    ///是否登录
    var isLogin: Bool{
        if userInfo == nil {
            return false
        }
        
        guard let expiresDate = userInfo?.expires_date else {
            return false
        }
         
        if NSDate().compare(expiresDate as Date) == .orderedAscending {
            return true
        }
        
        return false
    }
    
    
    
    init() {
        userInfo = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? UserAccount
    }
}
