//
//  HomeViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/3.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh
class HomeViewController: BaseViewController {
    static let HomeCellID: String = "HomeCellID"
    lazy var popoverAnimator = PopoverAnimator { (isPop) in
        self.titleView.isSelected = isPop
    }
    
    lazy var popoverVC = PopoverViewController()
    
    lazy var titleView = TitleView()
    
    lazy var statusArray = Array<UserViewModel>()
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 44-35+25, width: UIScreen.main.bounds.width, height: 0)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0)
        navigationController?.navigationBar.insertSubview(label, at: 0)
        return label
    }()
    // MARK: - life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLogin {
            setupNavi()
             
            handleTableview()
        }else {
            self.visitorView.addAnimation()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.mj_header?.beginRefreshing()
    }
}

// MARK: - UI
extension HomeViewController {
    private func setupNavi() {
        let leftBtn = UIButton(imageForH: "navigationbar_friendattention")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        leftBtn.addTarget(self, action: Selector(("leftBtnClick")), for: .touchUpInside)
        
        
        let rightBtn = UIButton(imageForH: "navigationbar_pop")
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        titleView.setTitle("coder", for: .normal)
        titleView.addTarget(self, action: Selector(("titleViewClick")), for: .touchUpInside)
        navigationItem.titleView = titleView;
    }
    
    private func handleTableview() {
        self.tableView.register(UINib(nibName: "HomeViewCell", bundle: Bundle.main), forCellReuseIdentifier: HomeViewController.HomeCellID)
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 200
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector(("loadNewData")))
        
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector(("loadMoreData")))
    }
    
    private func addTipLabel(count: Int) {
        if count == 0 {
            tipLabel.isHidden = true
        }else {
            tipLabel.isHidden = false
            tipLabel.text = "已更新\(count)条微博"
        }
    }
    
    private func showTipLabel() {
        UIView.animate(withDuration: 1.0, animations: {
            self.tipLabel.frame.size.height = 25
        }) { (_) in
            UIView.animate(withDuration: 1.0, delay: 0.8, options: [], animations: {
                self.tipLabel.frame.size.height = 0
            }) { (_) in
                
            }
        }
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
    @objc private func loadNewData() {
        loadStatusesWork(isNew : true)
        
    }
    
    @objc private func loadMoreData() {
        loadStatusesWork(isNew : false)
    }
}

// MARK: - NetWork
extension HomeViewController {
    // MARK: - 请求微博数据
    private func loadStatusesWork(isNew : Bool) {
        var since_id = 0
        var max_id = 0
        
        if isNew {
            since_id = statusArray.first?.status?.mid ?? 0
        }else {
            max_id = statusArray.last?.status?.mid ?? 0
            max_id = (max_id == 0) ? 0 : max_id - 1
        }
        
        DataManager.manager.loadStatuses(since_id: since_id,max_id: max_id,page: 1, count: 20, success: { (resp) in
            let data = resp.data(using: .utf8)!
            
            guard let json = try?JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                return
            }
            guard let jsonNSD = json as? NSDictionary else {
                return
            }
            guard let jsonDict = json as? [String: Any] else {
                return
            }
            
            
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
            let dp = (path as NSString).appendingPathComponent("dict.plist")
            jsonNSD.write(toFile: dp, atomically: true)
            
            guard let array = jsonDict["statuses"] as? Array<Dictionary<String, Any>> else {
                print("转数组失败")
                return
            }
        
           
            var tmpArray = Array<UserViewModel>()
            for dict in array {
                tmpArray.append(UserViewModel(dict: dict))
            }
            
            if isNew {
                self.statusArray = tmpArray + self.statusArray
                self.addTipLabel(count: tmpArray.count)
            }else {
                self.statusArray = self.statusArray + tmpArray
            }
            
            self.downloadPicImages()
        }) { (error) in
            
        }
    }
    // MARK: - 缓存请求的image
    private func downloadPicImages() {
        let group = DispatchGroup.init()
        
        for userModel in self.statusArray {
            for url in userModel.picUrls {
                group.enter(); SDWebImageDownloader.shared.downloadImage(with: url) { (_, _, _, _) in
                    group.leave()
                    
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            self.tableView.reloadData()
            self.showTipLabel()
        }
        
    }
}

// MARK: - tableView
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
