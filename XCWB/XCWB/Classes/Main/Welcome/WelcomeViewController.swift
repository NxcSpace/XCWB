//
//  WelcomeViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/7.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit
import SDWebImage
class WelcomeViewController: UIViewController {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let avatar = UserAccountViewModal.shareIntance.userInfo?.avatar_large else {
            return
        }
        
        let url = URL(string: avatar)
        
        iconView.sd_setImage(with: url!, placeholderImage: nil, options: [], context: nil)
        
        iconViewBottomCons.constant = UIScreen.main.bounds.height - 200
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 4, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (isFinish) in
            UIApplication.shared.keyWindow?.rootViewController = WBTabBarViewController()
        }
    }


    

}
