//
//  PopoverAnimator.swift
//  XCWB
//
//  Created by nxc on 2020/3/5.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    lazy var isPresented = true
    var presentedFrame: CGRect = CGRect.zero
    var callBack: ((_ presented: Bool) -> ())?
    
    init(callBack: @escaping ((_ presented: Bool) -> ())) {
        self.callBack = callBack
    }
}

extension PopoverAnimator: UIViewControllerTransitioningDelegate
{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationVC = WBPresentationController(presentedViewController: presented, presenting: presenting)
        presentationVC.presentedFrame = presentedFrame

        return presentationVC
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        self.callBack!(isPresented)
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        self.callBack!(isPresented)
        return self
    }
}

extension PopoverAnimator: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? presentedAnimation(transitionContext: transitionContext):dismissAnimation(transitionContext: transitionContext)
    }
    
    //显示动画
    func presentedAnimation(transitionContext: UIViewControllerContextTransitioning) {
        //获取弹出的view
        let presented = transitionContext.view(forKey: .to)!
        //将view加入到容器中
        transitionContext.containerView.addSubview(presented)
        //设置动画
        presented.transform = CGAffineTransform.init(scaleX: 1.0, y: 0)
        //设置锚点
        presented.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0)
        UIView.animate(withDuration: 0.5, animations: {
            presented.transform = CGAffineTransform.identity
        }) { (isFinished) in
            //结束动画
            transitionContext.completeTransition(isFinished)
        }
    }
    
    //消失动画
    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
        //获取弹出的view
        let dismiss = transitionContext.view(forKey: .from)!
        //设置锚点
       // presented.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0)
        UIView.animate(withDuration: 0.5, animations: {
            dismiss.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.01)
        }) { (isFinished) in
            //结束动画
            transitionContext.completeTransition(isFinished)
        }
    }
    
}
