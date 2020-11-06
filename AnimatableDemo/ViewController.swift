//
//  ViewController.swift
//  AnimatableDemo
//
//  Created by Shafujiu on 2020/11/5.
//

import UIKit
import IBAnimatable

class ViewController: AnimatableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        let alert = UIAlertController(title: "测试title", message: "测试message", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "default", style: .default, handler: { (action) in
//            print("default")
//        }))
//        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (_) in
//            print("cancel")
//        }))
//        present(alert, animated: true, completion: nil)
        
        
        let alert = SFJAlertController.alert(title: nil, message: nil)
        alert.addAction(SFJAlertAction("下一份", .default(nil), {

        }))
        alert.addAction(SFJAlertAction("确认", .confirm(nil), {

        }))
        present(alert, animated: true, completion: nil)
    }
}
