//
//  ComposeViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/8.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    private lazy var titleView : ComposeTitleView = ComposeTitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

}

// MARK: - UI
extension ComposeViewController {
    private func setupNavigationBar() {
        // 1.设置左右的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: Selector(("closeItemClick")))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: Selector(("sendItemClick")))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // 2.设置标题
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = titleView
    }
}


// MARK:- Action
extension ComposeViewController {
    @objc private func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func sendItemClick() {
        print("sendItemClick")
    }
}

