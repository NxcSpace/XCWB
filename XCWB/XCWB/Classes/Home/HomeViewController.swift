//
//  HomeViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/3.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

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

extension HomeViewController{
    @objc private func titleViewClick() {
        print("ddd")
        titleView.isSelected = !titleView.isSelected
        
        popoverVC.view.backgroundColor = UIColor.clear
        popoverVC.modalPresentationStyle = .custom
        present(popoverVC, animated: true, completion: nil)
        
        
    }
    
}
