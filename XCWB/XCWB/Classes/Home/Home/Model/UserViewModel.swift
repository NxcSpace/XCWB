//
//  UserViewModel.swift
//  XCWB
//
//  Created by nxc on 2020/3/7.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class UserViewModel: NSObject {
    var status: Status?
    
    // MARK:- 对微博数据处理
    var sourceText: String = ""
    var createAtText: String = ""
    var picUrls = [URL]()
    var reContentText: String = ""
    
    // MARK:- 对用户数据处理
    var verifiedImage : UIImage?
    var vipImage : UIImage?
    var profileImageUrl : URL?
    
    
    
    init(dict: [String: Any]) {
        super.init()
        status = Status(dict: dict)
       
        handlStatus()
        handlUser()
    }
}

// MARK: - 处理属性
extension UserViewModel {
    
    private func handlStatus() {
        // 1.nil值校验
        if let created_at = status?.created_at {
            // 2.对时间处理
            createAtText = NSDate.createDateString(createAtStr: created_at)
        }
        
        // 1.nil值校验
        if let source = status?.source, source != "" {
            // 2.对来源的字符串进行处理
            // 2.1.获取起始位置和截取的长度
            let startIndex = (source as NSString).range(of:">").location + 1
            let length = (source as NSString).range(of:"</").location - startIndex
            
            // 2.2.截取字符串
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        
        // 校验微博配图
       if let urls = status?.pic_urls {
           for dict in urls {
               guard let url = dict["thumbnail_pic"] else {
                   continue
               }
               picUrls.append(URL(string: url)!)
           }
       }
//        if status?.retweeted_status != nil {
//            if let urls = status?.retweeted_status?.pic_urls {
//                for dict in urls {
//                    guard let url = dict["thumbnail_pic"] else {
//                        continue
//                    }
//                    picUrls.append(URL(string: url)!)
//                }
//            }
//        } else {
//            if let urls = status?.pic_urls {
//                for dict in urls {
//                    guard let url = dict["thumbnail_pic"] else {
//                        continue
//                    }
//                    picUrls.append(URL(string: url)!)
//                }
//            }
//        }

        // 校验转发
        if let reContent = status?.retweeted_status?.text,
            let reUser = status?.retweeted_status?.user?.screen_name{
            reContentText = "@\(reUser): \(reContent)" 
        }
       
        
    }

    private func handlUser() {
        if let profileImageUrl = status?.user?.profile_image_url {
            
            if profileImageUrl != "" {
                self.profileImageUrl = URL(string: profileImageUrl)
            }
        }
        
        let mbrank = status?.user?.mbrank ?? 0
        
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        let verified_type = status?.user?.verified_type ?? -1
        
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
    }
}
