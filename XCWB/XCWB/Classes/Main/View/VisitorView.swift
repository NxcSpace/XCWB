//
//  VisitorView.swift
//  XCWB
//
//  Created by nxc on 2020/3/4.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK: - 从xib初始化
    class func visitorViewForNib() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    
    // MARK: - 设置控件信息
    func setupVisitorInfo(title: String, icon: String){
        self.title.text = title
        self.icon.image = UIImage(named: icon)
        backIcon.isHidden = true
    }
    
    // MARK: - 设置动画
    func addAnimation() {
        //
        let k = CABasicAnimation(keyPath: "transform.rotation.z")
        //
        k.fromValue = 0
        k.toValue = 2 * Double.pi
        k.duration = 15
        k.repeatCount = MAXFLOAT
        k.isRemovedOnCompletion = false
        //
        backIcon.layer.add(k, forKey: nil)
    }

}
