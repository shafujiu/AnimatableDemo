//
//  BaseAlertController.swift
//  AnimatableDemo
//
//  Created by Shafujiu on 2020/11/5.
//

import UIKit
import IBAnimatable



class SFJAlertAction {
    
    // 自定义配置颜色
    
    
    enum Style {
        case `default`(_ titleColor: UIColor?)    // 蓝色底的
        case confirm(_ titleColor: UIColor?)
    }
    
    private(set) var style: Style
    private(set) var title: String?
    private(set) var handler: (() -> Void)? = nil
    
    init( _ title: String?, _ style: Style, _ handler: (() -> Void)?) {
        self.style = style
        self.title = title
        self.handler = handler
    }
}

class SFJAlertController: AnimatableModalViewController {
    private let kActionIndexOffset = 1000
    private let kStandSpace: CGFloat = 35
    private let kDefaultBtnColor = UIColor.black
    private let kConfirmBtnColor = UIColor.blue
    
    private var message: String?
    private(set) var actions: [SFJAlertAction] = []
    
    @IBOutlet private weak var contentV: UIView!
    @IBOutlet private weak var textContentTopC: NSLayoutConstraint!
    @IBOutlet private weak var textContentBottomC: NSLayoutConstraint!
    
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var messageLbl: UILabel!
    @IBOutlet private weak var messegeView: UIView!
    
    @IBOutlet private weak var btnCenterSegView: UIView!
    @IBOutlet private weak var bottomContentStack: UIStackView!
    
    
    static func alert(title: String? = nil, message: String? = nil) -> SFJAlertController {
        let sb = UIStoryboard(name: "SFJAlert", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SFJAlertController") as! SFJAlertController
        // opacity viewDidLoad 配置不生效的
        vc.opacity = 0.3
        vc.title = title
        vc.message = message
        return vc
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addAction(_ action: SFJAlertAction) {
        actions.append(action)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func configUI() {
        // 可以再优化
        let width = PresentationModalSize.full
        let height = PresentationModalSize.custom(size: Float(contentV.frame.height))
        modalSize = ModalSize(width: width, height: height)
//        // 需要注意顺序 优先设置大小 再设置动画类型
        presentationAnimationType = .crossDissolve
        dismissalAnimationType = .crossDissolve
            
        // 配置title、message
        if let title = self.title {
            titleLbl.text = title
        } else {
            titleView.isHidden = true
            textContentTopC.constant = kStandSpace
            textContentBottomC.constant = kStandSpace
        }
        
        if let message = self.message {
            messageLbl.text = message
        } else {
            messegeView.isHidden = true
            textContentTopC.constant = kStandSpace
            textContentBottomC.constant = kStandSpace
        }
        // 配置actions
        if actions.count == 0 {
            // 默认加个确认
            addAction(SFJAlertAction("确认", .confirm(kConfirmBtnColor), nil))
        }
        addActionBtns()

    }
    
    private func addActionBtns() {
        btnCenterSegView.isHidden = actions.count <= 1
        actions.enumerated().forEach { [weak self] (index, action) in
            let btn = UIButton(type: .system)
            btn.setTitle(action.title, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            switch action.style {
            case .`default`(let color):
                if let co = color {
                    btn.setTitleColor(co, for: .normal)
                } else {
                    btn.setTitleColor(kDefaultBtnColor, for: .normal)
                }
            case .confirm(let color):
                if let co = color {
                    btn.setTitleColor(co, for: .normal)
                } else {
                    btn.setTitleColor(kConfirmBtnColor, for: .normal)
                }
            }
            btn.tag = kActionIndexOffset + index
            btn.addTarget(self, action: #selector(btnAct(_:)), for: .touchUpInside)
            self?.bottomContentStack.addArrangedSubview(btn)
        }
    }
    
    @objc private func btnAct(_ sender: UIButton) {
        let index = sender.tag - kActionIndexOffset
        guard let handler = actions[index].handler else {
            dismiss(animated: true, completion: nil)
            return
        }
        handler()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        guard let point = touch?.location(in: contentV), !contentV.bounds.contains(point) else {
            return
        }
        dismiss(animated: true, completion: nil)
    }

}
