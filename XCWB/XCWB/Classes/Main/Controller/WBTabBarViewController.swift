//
//  WBTabBarViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/3.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class WBTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        addChild(vc: HomeViewController(), imageStr: "tabbar_home", title: "首页")
        addChild(vc: MessageViewController(), imageStr: "tabbar_message_center", title: "消息")
        addChild(vc: DiscoverViewController(), imageStr: "tabbar_discover", title: "发现")
        addChild(vc: ProfileViewController(), imageStr: "tabbar_profile", title: "我")
        
        setupTabBar()
    }
}

// MARK: - 设置UI
extension WBTabBarViewController {
    
    // MARK: - 添加子vc
    func addChild(vc: UIViewController, imageStr: String, title: String) {
           let navi = UINavigationController(rootViewController: vc)
           self.addChild(navi)
           navi.tabBarItem.title = title;
           navi.tabBarItem.image = UIImage(named: imageStr)
           navi.tabBarItem.selectedImage = UIImage(named: imageStr + "_highlighted")
       }
    
    // MARK: - 自定义tabBar
    func setupTabBar() {
        let bar = WBTabBar()
        setValue(bar, forKey: "tabBar")
    }
}
