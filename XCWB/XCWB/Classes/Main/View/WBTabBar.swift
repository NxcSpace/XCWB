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
    lazy var composeBtn: UIButton = {
        let composeBtn = UIButton(image: "tabbar_compose_icon_add", backImage: "tabbar_compose_button")
        return composeBtn
    }()
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = self.frame.size.width / 5
        let h = self.frame.size.height
        
        self.addSubview(composeBtn)
        composeBtn.addTarget(self, action: Selector(("composeBtnClick")), for: .touchDown)
        composeBtn.center.x = self.frame.size.width * 0.5
        composeBtn.center.y = self.frame.size.height * 0.5
        
        var index = 0
        for case let item in self.subviews {
            
            if item.isKind(of: NSClassFromString("UITabBarButton")!) {
                if index == 2 {
                    index += 1
                }
                item.frame = CGRect(x: w * CGFloat(index), y: 0, width: w, height: h)
                index += 1
            }
        }
    } 
}

// MARK: - 事件监听
extension WBTabBar {
    @objc private func composeBtnClick() {
       
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        let navi = UINavigationController.init(rootViewController: ComposeViewController())
        navi.modalPresentationStyle = .fullScreen
        vc.present(navi, animated: true, completion: nil)
    }
}
