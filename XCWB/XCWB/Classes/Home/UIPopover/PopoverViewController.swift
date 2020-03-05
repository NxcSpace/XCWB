//
//  PopoverViewController.swift
//  XCWB
//
//  Created by nxc on 2020/3/4.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        backImage.frame = CGRect(x: (UIScreen.main.bounds.size.width-200)*0.5, y: 64, width: 200, height: 300)
//        tableView.frame = CGRect(x: (UIScreen.main.bounds.size.width-180)*0.5, y: 74, width: 180, height: 280)
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        dismiss(animated: true, completion: nil)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
