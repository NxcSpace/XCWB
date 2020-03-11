//
//  FindEmoticon.swift
//  RegexDemo
//
//  Created by nxc on 2020/3/11.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class FindEmoticon: NSObject {
    static let emoticon: FindEmoticon = FindEmoticon()
    lazy var emoMnanger = EmoticnManager()
    func findEmojiReplaceAttrStr(str: String?, font: UIFont) -> NSMutableAttributedString? {
        //let pattern = "@.*?:"
        // let pattern = "#.*?#"
        guard let str = str else {
            return nil
        }
        
        
        let pattern = "\\[.*?\\]"
        
        //let pattern = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        
        let results = regex?.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
        
        guard let r = results else {
            return nil
        }
        
        let attrMuText = NSMutableAttributedString(string: str)
        var idx = 0
        for _ in r {
            let res = r[r.count - 1 - idx]
            
            let chs = (str as NSString).substring(with: res.range)
            
            guard let png = getPngPath(str: chs) else {
                return nil
            }
            idx += 1
            let image = UIImage(named: png)!
            
            //NSTextAttachment(image: image)
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attr = NSAttributedString(attachment: attachment)
            attrMuText.replaceCharacters(in: res.range, with: attr)
        }
        attrMuText.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attrMuText.length))
        attrMuText.removeAttribute(NSAttributedString.Key.foregroundColor, range: NSRange(location: 0, length: attrMuText.length))
        return attrMuText
    }
    
    
    private func getPngPath(str: String) -> String? {
        
        for package in emoMnanger.packageArr {
            for emo in package.array {
                if emo.chs == str {
                    return emo.iconPath
                }
            }
        }
        return nil
    }
}
