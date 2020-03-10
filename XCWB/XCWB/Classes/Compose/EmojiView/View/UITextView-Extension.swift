//
//  UITextView-Extension.swift
//  EmojiKeyBordDemo
//
//  Created by nxc on 2020/3/10.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

extension UITextView {
    func insterEmoticons(emoticn: Emoticn) {
        if emoticn.emptyFlag{
            return
        }
        //删除
        if emoticn.deleteFlag {
            deleteBackward()
            return
        }
        //插入emoji
        if let emoStr = emoticn.emojiStr {
            // 3.1.获取光标所在的位置:UITextRange
            let textRange = selectedTextRange!
            
            replace(textRange, withText: emoStr)
        }
        //插入图片
        if emoticn.png != nil {
            //将image包装成富文本
            let image = UIImage(named: emoticn.iconPath!)!
            
            let attachment = EmoticonTextAttachment()
            attachment.image = image
            attachment.chs = emoticn.chs ?? ""
            let font = self.font!
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attrImage = NSAttributedString(attachment: attachment)
            
            //获取textView的富文本
            guard let attrText = attributedText else {
                return
            }

           let attrMuText = NSMutableAttributedString(attributedString: attrText)
            attrMuText.removeAttribute(NSAttributedString.Key.foregroundColor, range: NSRange(location: 0, length: attrText.length))
           attrMuText.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attrText.length))
            //将图 添加到 textview的光标处
            let range = selectedRange
            attrMuText.replaceCharacters(in: range, with: attrImage)
            attributedText = attrMuText
            
            //解决光标问题 字号
            selectedRange = NSRange(location: range.location + 1, length: 0)
            self.font = font
        }
    }
    
    func getEmoticonsStr() -> String {
        let attri = NSMutableAttributedString(attributedString: attributedText)
        
        attri.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: attri.length), options: []) { (attachment , range, _) in
            if let emachment = attachment as? EmoticonTextAttachment {
                attri.replaceCharacters(in: range, with: emachment.chs)
            }
        }
        return attri.string
    }
}
