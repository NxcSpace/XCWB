//
//  WBTabBar.swift
//  XCWB
//
//  Created by nxc on 2020/3/3.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class WBTabBar: UITabBar {
    ///发布按钮
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        return button
    }()
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = self.frame.size.width / 5
        let h = self.frame.size.height
        
        self.addSubview(button)
        button.sizeToFit()
        button.center.x = self.frame.size.width * 0.5
        button.center.y = self.frame.size.height * 0.5
        
        var index = 0
        for case let item in self.subviews {
            
            if item.isKind(of: NSClassFromString("UITabBarButton")!) {
                if index == 2 {
                    index += 1
                }
                item.frame = CGRect(x: w * CGFloat(index), y: 0, width: w, height: h)
                print(item.frame)
                index += 1
            }
        }
    } 
}
