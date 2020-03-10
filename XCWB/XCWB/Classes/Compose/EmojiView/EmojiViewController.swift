//
//  EmojiViewController.swift
//  EmojiKeyBordDemo
//
//  Created by nxc on 2020/3/9.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit
private let EmoticonCell = "EmoticonCell"
class EmojiViewController: UIViewController {
    var callBack: ((_ emoticn: Emoticn) -> ())
    lazy var emoticnManager = EmoticnManager()
    var toolBar: UIToolbar = UIToolbar()
    var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmojiCollectionViewLayout())
    
    
    init(callBack: @escaping (_ emoticn: Emoticn) -> ()) {
        self.callBack = callBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.brown
        
        setupUI()
    }
}
// MARK: - UI
extension EmojiViewController {
    func setupUI() {
        view.addSubview(toolBar)
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.purple
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(EmoCollectionViewCell.self, forCellWithReuseIdentifier: EmoticonCell)
        
        toolBar.backgroundColor = UIColor.darkGray
        
        // 2.设置子控件的frame
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["tBar" : toolBar, "cView" : collectionView]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[cView]-0-[tBar]-0-|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        perpareToolbar()
    }
    
    func perpareToolbar() {
        // 1.定义toolBar中titles
        let titles = ["最近", "默认", "emoji", "浪小花"]
        
        // 2.遍历标题,创建item
        var index = 0
        var tempItems = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(itemClick(item:)))
            item.tag = index
            index += 1
            
            tempItems.append(item)
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        
        // 3.设置toolBar的items数组
        tempItems.removeLast()
        toolBar.items = tempItems
        toolBar.tintColor = UIColor.orange
        
    }
    
    @objc private func itemClick(item : UIBarButtonItem) {
        
        let indexPath = NSIndexPath(item: 0, section: item.tag)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
    }
}
// MARK: - UICollectionViewDelegate && DataSource
extension EmojiViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emoticnManager.packageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = emoticnManager.packageArr[section]
        
        return package.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonCell, for: indexPath) as! EmoCollectionViewCell
        let package = emoticnManager.packageArr[indexPath.section]
        cell.emoModel = package.array[indexPath.row]
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.systemPink : UIColor.lightGray
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package = emoticnManager.packageArr[indexPath.section]
        let model = package.array[indexPath.row]
        self.callBack(model)
    
        if indexPath.section == 0 {
            return
        }
       
        if model.emptyFlag || model.deleteFlag {
            return
        }
        
        let firstPackage = emoticnManager.packageArr[0]
       
        if firstPackage.array.contains(model){
            let idx = (firstPackage.array as NSArray).index(of: model)
            firstPackage.array.remove(at: idx)
        }else {
            firstPackage.array.remove(at: 19)
            
        }
        firstPackage.array.insert(model, at: 0)

        
        collectionView.reloadSections(IndexSet(integer: 0))
        
    }
}

class EmojiCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        //super.prepare()
        // 1.计算itemWH
        let itemWH = UIScreen.main.bounds.width / 7
        
        // 2.设置layout的属性
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        
        // 3.设置collectionView的属性
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        let insetMargin = (collectionView!.bounds.height - 3 * itemWH) / 2
        collectionView?.contentInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
    }
    
}


