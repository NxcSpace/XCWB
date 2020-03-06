//
//  OAuthViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/6.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavi()
        
        loadUrlPage()
    }
}

// MARK: - UI
extension OAuthViewController {
    private func setupNavi(){
        self.title = "登录"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: Selector(("dissMissClick")))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: Selector(("inputClick")))
    }
    
    func loadUrlPage(){
    
        guard let url = URL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)") else {
            
            return
        }
        
        let request = URLRequest(url: url)
        
        webView.loadRequest(request)
        
        webView.delegate = self as UIWebViewDelegate
    }
}

// MARK: - Action
extension OAuthViewController {
    @objc private func dissMissClick(){
        dismiss(animated: true, completion: nil)
    }
    @objc private func inputClick(){
        let jsCode = ""
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

// MARK: - UIWebViewDelegate
extension OAuthViewController: UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        guard let url = request.url else {
            return true
        }
        
        let str = url.absoluteString
        print("url:\(url)")
        
        guard str.contains("code=") else {
            return true
        }
        
        let code = str.components(separatedBy: "code=").last!
        print("code:\(code)")
        
        //请求数据
        loadAccessToken(code: code)
        return false
    }
}

// MARK: - 请求数据
extension OAuthViewController {
    private func loadAccessToken(code: String){
        DataManager.manager.loadAccessToken(code: code, success: { (resp) in
            let data = resp.data(using: .utf8)!
            let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let userDict = dict as? [String : Any] else {
                print("字典出错")
                return
            }
            
            let user = UserAccount(dict: userDict)
            
            self.loadUserInfo(userInfo: user)
        }) { (error) in
            
        }
    }
    
    private func loadUserInfo(userInfo: UserAccount){
        DataManager.manager.loadUserInfo(userInfo: userInfo, success: { (resp) in
            let data = resp.data(using: .utf8)!
            let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let userInfoDict = dict as? [String : Any] else {
                print("字典出错")
                return
            }
            
            userInfo.avatar_large = userInfoDict["avatar_large"] as? String
            userInfo.screen_name = userInfoDict["screen_name"] as? String
            print(userInfo)
        }) { (error) in
            
        }
        
    }
    
}
