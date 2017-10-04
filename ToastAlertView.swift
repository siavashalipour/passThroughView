//
//  ToastAlertView.swift
//  Nomble
//
//  Created by Siavash on 3/10/17.
//  Copyright © 2017 Siavash. All rights reserved.
//

import Foundation
import SnapKit

protocol ToastAlertViewDelegate {
    func didTapToast()
}
final class ToastAlertView: UIView {
    
    var delegate: ToastAlertViewDelegate?
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.font = UIFont.niPageTitle
        l.textColor = UIColor.niWhiteTwo
        return l
    }()
    
    private lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.font = UIFont.niPageTitle
        l.textColor = UIColor.niWhiteTwo
        l.text = NSLocalizedString("View", comment: "")
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.didTapOnToastView))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        addGestureRecognizer(tap)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(UIConst.Size.defaultLeftRightPadding)
        }
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-UIConst.Size.defaultLeftRightPadding)
            make.width.equalTo(35)
            make.left.equalTo(titleLabel.snp.right).offset(16)
        }
    }
    func showAlert(with title: String, on view: UIView) {
        titleLabel.text = title
        view.addSubview(self)
        self.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(UIConst.Size.toastAlertHeight)
            make.height.equalTo(UIConst.Size.toastAlertHeight)
        }
        self.perform(#selector(self.animateUp(on:)), with: view, afterDelay: 1)

    }
    
    @objc
    private func animateUp(on view: UIView) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.snp.updateConstraints({ (make) in
                make.bottom.equalTo(0)
            })
            view.layoutIfNeeded()
        }) { (_) in
        }
        self.perform(#selector(self.animateDown(on:)), with: view, afterDelay: 2)
        
    }
    
    @objc
    private func animateDown(on view: UIView) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.snp.remakeConstraints { (make) in
                make.left.right.equalTo(view)
                make.bottom.equalTo(UIConst.Size.toastAlertHeight)
            }
            view.layoutIfNeeded()
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @objc
    private func didTapOnToastView() {
        delegate?.didTapToast()
    }
}
