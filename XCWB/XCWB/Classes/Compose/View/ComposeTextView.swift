//
//  ComposeTextView.swift
//  XCWB
//
//  Created by nxc on 2020/3/9.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {

    lazy var placeholderLabel = UILabel()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
       
       
    }
    

}

extension ComposeTextView {
    func setupUI() {
        placeholderLabel.text = "请输入微博"
        placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.frame = CGRect.init(x: 5, y: 5, width: 100, height: 30)
        self.addSubview(placeholderLabel)
    }
}

