//
//  WBPresentationController.swift
//  XCWB
//
//  Created by nxc on 2020/3/5.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class WBPresentationController: UIPresentationController {
    private lazy var coverView: UIView = UIView()
    var presentedFrame: CGRect = CGRect.zero
    
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = presentedFrame
        
        setupCoverView()
    }
}

// MARK: - UI
extension WBPresentationController
{
    private func setupCoverView(){
        coverView.frame = containerView!.bounds
        coverView.backgroundColor = UIColor.init(white: 0.8, alpha: 0.3)
        containerView?.insertSubview(coverView, at: 0)
        
        let tap = UITapGestureRecognizer(target: self, action: Selector(("tapAction")))
        
        coverView.addGestureRecognizer(tap)
    }
}

// MARK: - Action
extension WBPresentationController
{
    @objc private func tapAction() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
