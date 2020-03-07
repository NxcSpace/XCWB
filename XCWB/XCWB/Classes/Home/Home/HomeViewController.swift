//
//  HomeViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/3.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    static let HomeCellID: String = "HomeCellID"
    lazy var popoverAnimator = PopoverAnimator { (isPop) in
        self.titleView.isSelected = isPop
    }
    
    lazy var popoverVC = PopoverViewController()
    
    lazy var titleView = TitleView()
    
    lazy var statusArray = Array<UserViewModel>()
    // MARK: - life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLogin {
            setupNavi()
             
            self.tableView.register(UINib(nibName: "HomeViewCell", bundle: Bundle.main), forCellReuseIdentifier: HomeViewController.HomeCellID)
            self.tableView.separatorStyle = .none
            self.tableView.estimatedRowHeight = 200
            loadStatusesWork()
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
        leftBtn.addTarget(self, action: Selector(("leftBtnClick")), for: .touchUpInside)
        
        
        let rightBtn = UIButton(imageForH: "navigationbar_pop")
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        titleView.setTitle("coder", for: .normal)
        titleView.addTarget(self, action: Selector(("titleViewClick")), for: .touchUpInside)
        navigationItem.titleView = titleView;
    }
    
    
}

// MARK: - Action
extension HomeViewController {
    @objc private func titleViewClick() {
        popoverVC.view.backgroundColor = UIColor.clear
        popoverVC.modalPresentationStyle = .custom
        popoverVC.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: (UIScreen.main.bounds.size.width-200)*0.5, y: 60, width: 200, height: 300)
        present(popoverVC, animated: true, completion: nil)
    }
    @objc private func leftBtnClick(){
        let welcome = WelcomeViewController()
        navigationController!.pushViewController(welcome, animated: true)
        
    }
}

// MARK: - NetWork
extension HomeViewController {
    // MARK: - 请求微博数据
    func loadStatusesWork() {
        DataManager.manager.loadStatuses(page: 1, count: 20, success: { (resp) in
            let data = resp.data(using: .utf8)!
            
            guard let json = try?JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                return
            }
            
            guard let array = json["statuses"] as? Array<Dictionary<String, Any>> else {
                print("转数组失败")
                return
            }
            
            for dict in array {
                self.statusArray.append(UserViewModel(dict: dict))
            }
            
            print(self.statusArray)
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }
    
}

// MARK: -
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = statusArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.HomeCellID) as! HomeViewCell
        
        cell.userModel = model
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
