//
//  HomeViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/3.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    lazy var popoverAnimator = PopoverAnimator { (isPop) in
        self.titleView.isSelected = isPop
    }
    lazy var popoverVC = PopoverViewController()
    lazy var titleView = TitleView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLogin {
            setupNavi()
        }else {
            self.visitorView.addAnimation()
        }
    }

}

// MARK: - UI
extension HomeViewController {
    func setupNavi() {
        let leftBtn = UIButton(imageForH: "navigationbar_friendattention")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let rightBtn = UIButton(imageForH: "navigationbar_pop")
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        titleView.setTitle("coder", for: .normal)
        titleView.addTarget(self, action: Selector(("titleViewClick")), for: .touchUpInside)
        navigationItem.titleView = titleView;
    }
    
}

// MARK: - Action
extension HomeViewController
{
    @objc private func titleViewClick() {
        popoverVC.view.backgroundColor = UIColor.clear
        popoverVC.modalPresentationStyle = .custom
        popoverVC.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: (UIScreen.main.bounds.size.width-200)*0.5, y: 60, width: 200, height: 300)
        present(popoverVC, animated: true, completion: nil)
    }
}


