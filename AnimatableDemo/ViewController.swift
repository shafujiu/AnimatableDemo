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

    @IBAction func showAlertAct(_ sender: Any) {
        
        let alert = SFJAlertController.alert(title: nil, message: nil)
        alert.addAction(SFJAlertAction("下一份", .default(nil), {

        }))
        alert.addAction(SFJAlertAction("确认", .confirm(nil), {

        }))
        present(alert, animated: true, completion: nil)
    }
}
