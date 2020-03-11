//
//  ComposeViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/8.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit
import SVProgressHUD
class ComposeViewController: UIViewController {
    let cellID = "PicSelCollectionViewCell"
    lazy var emoVc: EmojiViewController = EmojiViewController {[weak self] (emo) in
        self?.compTextView.insterEmoticons(emoticn: emo)
        self?.textViewDidChange(self!.compTextView )
    }
    private lazy var titleView : ComposeTitleView = ComposeTitleView()
    lazy var imageArr = Array<UIImage>()
    @IBOutlet weak var bottomToolBarComs: NSLayoutConstraint!
    
    @IBOutlet weak var compTextView: ComposeTextView!
    
    @IBOutlet weak var heightPicCollViewCons: NSLayoutConstraint!
    @IBOutlet weak var picCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNotification()
        setupCollectionView()
        self.addChild(emoVc)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //self.heightPicCollViewCons.constant = UIScreen.main.bounds.height * 0.65
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        compTextView.becomeFirstResponder()
    }
    
    @IBAction func picPickerBtnClick(_ sender: Any) {
        compTextView.resignFirstResponder()
        self.heightPicCollViewCons.constant = UIScreen.main.bounds.height * 0.65
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func emojiButtonClick(_ sender: Any) {
        compTextView.resignFirstResponder()
        compTextView.inputView = compTextView.inputView != nil ? nil : emoVc.view
    
        compTextView.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    private func setupNotification() {
        // 监听键盘弹出通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification,object: nil)
        // 监听键盘隐藏通知
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHide(notification:)),name: UIResponder.keyboardWillHideNotification, object: nil)
        //监听点击选择照片按钮
        NotificationCenter.default.addObserver(self,selector: #selector(modalPicSelAction),name: Notification.Name(rawValue: ModalPicSelectPickerNotifiction), object: nil)
        
        //监听删除照片按钮
        NotificationCenter.default.addObserver(self,selector: #selector(deletePicSelAction(notification:)),name: Notification.Name(rawValue: DeletePicSelectPickerNotifiction), object: nil)
        
    }
    
    private func setupCollectionView() {
        picCollectionView.delegate = self
        picCollectionView.dataSource = self
        picCollectionView.register(UINib(nibName: "PicSelCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellID)
        let layout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let space: CGFloat = 10.0
        let itemWH = (UIScreen.main.bounds.width - 4.0 * space) / 3
        
        layout.itemSize = CGSize.init(width: itemWH, height: itemWH)
        
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        picCollectionView.contentInset = UIEdgeInsets.init(top: space, left: space, bottom: 0, right: space)
        
    }
}


// MARK:- Action
extension ComposeViewController {
    @objc private func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func sendItemClick() {
        SVProgressHUD.show()
        if imageArr.count > 0 {
            DataManager.manager.uploadImage(statusText: compTextView.getEmoticonsStr(), image: imageArr.first!, success: { (resp) in
                print(resp)
                SVProgressHUD.showSuccess(withStatus: "发送成功")
                self.dismiss(animated: true, completion: nil)
            }) { (error) in
                
            }
        }else {
            DataManager.manager.sendStatuses(statusText: compTextView.getEmoticonsStr(), success: { (resp) in
                SVProgressHUD.showSuccess(withStatus: "发送成功")
                self.dismiss(animated: true, completion: nil)
            }) { (eror) in
                
            }
        }
        
        
        
    }
    // 键盘显示
    @objc func keyboardWillShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo else {
            return
        }
        
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
        let rect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let cons = UIScreen.main.bounds.height - rect.origin.y
        bottomToolBarComs.constant = cons
        UIView.animate(withDuration: duration as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
        
    }
    // 键盘隐藏
    @objc func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
        
        bottomToolBarComs.constant = 0
        UIView.animate(withDuration: duration as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func modalPicSelAction() {
        
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        let pic = UIImagePickerController()
        pic.sourceType = .photoLibrary
        pic.delegate = self
        pic.modalPresentationStyle = .fullScreen
        present(pic, animated: true, completion: nil)
        
    }
    @objc func deletePicSelAction(notification: Notification) {
        
        guard let image = notification.object as? UIImage else {
            return
        }
        
        guard let index = imageArr.firstIndex(of: image) else {
            return
        }
        
        imageArr.remove(at: index)
        picCollectionView.reloadData()
    }
    
    
    
}
// MARK: - UITextViewDelegate
extension ComposeViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        compTextView.placeholderLabel.isHidden = compTextView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = compTextView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        compTextView.resignFirstResponder()
        heightPicCollViewCons.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
// MARK: - UICollectionViewDelegate
extension ComposeViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PicSelCollectionViewCell
        if indexPath.row == imageArr.count {
            cell.image = nil
        }else {
            cell.image = imageArr[indexPath.row]
        }
        
        return cell
    }
    
    
}

// MARK: - UIImagePickerControllerDelegate
extension ComposeViewController: UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageArr.append(image)
        picCollectionView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}
