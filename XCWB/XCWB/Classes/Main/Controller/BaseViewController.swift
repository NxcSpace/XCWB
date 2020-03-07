//
//  BaseViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/4.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    // MARK: - 访客视图
    lazy var visitorView: VisitorView = VisitorView.visitorViewForNib()
    // MARK: - 是否登录
    var isLogin: Bool = UserAccountViewModal.shareIntance.isLogin
    
    // MARK: - 生命周期
    override func loadView() {
        
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserAccountViewModal.shareIntance.userInfo ?? "")
    }
    
    
    
}

// MARK: - UI
extension BaseViewController {
    private func setupVisitorView() {
        view = visitorView
        setupUI()
    }
    
    private func setupUI(){
        visitorView.registerBtn.addTarget(self, action: Selector(("registerBtnClick")), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: Selector(("loginBtnClick")), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: Selector(("registerBtnClick")))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: Selector(("loginBtnClick")))
        
    }
}

// MARK: - Action
extension BaseViewController {
    @objc private func loginBtnClick() {
        let oauthVC = OAuthViewController()
        let navi = UINavigationController(rootViewController: oauthVC)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true, completion: nil)
        
        
    }
    
    @objc private func registerBtnClick() {
        print("reg")
    }
}
