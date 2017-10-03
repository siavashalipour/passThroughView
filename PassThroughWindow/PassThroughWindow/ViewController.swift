//
//  ViewController.swift
//  PassThroughWindow
//
//  Created by Siavash on 4/10/17.
//  Copyright © 2017 Siavash. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var ds: [Int] = []
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.register(MyCell.self, forCellReuseIdentifier: "MyCell")
        t.delegate = self
        t.dataSource = self
        return t
    }()
    private lazy var fabView: FABView = {
        let v = FABView()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0...100 {
            ds.append(i)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        fabView.removeFromSuperview()
    }
    @IBAction func show(_ sender: UIBarButtonItem) {
        view.addSubview(fabView)
        fabView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCell
        if let aCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MyCell {
            cell = aCell
        } else {
            cell = MyCell()
        }
        cell.config(with: ds[indexPath.row])
        return cell 
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}

final class MyCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = .black
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    private func setupUI() {
        
        _ = contentView.subviews.map({
            $0.removeFromSuperview()
        })
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.centerY.equalToSuperview()
        }
    }
    func config(with data: Int) {
        titleLabel.text = "\(data)"
    }
}
