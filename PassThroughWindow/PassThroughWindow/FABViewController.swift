//
//  FABViewController.swift
//  PassThroughWindow
//
//  Created by Siavash on 4/10/17.
//  Copyright © 2017 Siavash. All rights reserved.
//

import Foundation
import SnapKit

class PassThroughView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let test = super.hitTest(point, with: event)
        if let test = test, test === self {
            return nil
        }
        return test
    }
}


final class FABView: PassThroughView {
    private lazy var roundedBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        b.layer.cornerRadius = 8
        b.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        b.setTitle("Tap Me", for: .normal)
        b.addTarget(self, action: #selector(btnDidTap), for: .touchUpInside)
        return b
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    private func setupUI() {
        roundedBtn.removeFromSuperview()
        addSubview(roundedBtn)
        roundedBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-44)
            make.height.equalTo(40)
            make.right.equalTo(-20)
            make.width.equalTo(44)
        }
    }
    
    @objc
    private func btnDidTap() {
        print("btn tap")
    }
        
}

