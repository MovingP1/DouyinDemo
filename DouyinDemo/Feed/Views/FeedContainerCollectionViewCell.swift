//
//  FeedContainerCollectionViewCell.swift
//  DouyinDemo
//
//  Created by jiahong on 2025/10/21.
//

import UIKit
import SnapKit

class FeedContainerCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifierString = "FeedContainerCollectionViewCell"
    
    private var viewController:UIViewController?
    
    public func config(with viewController:UIViewController){
        //删除上一个展示的控制器
        self.viewController?.view.removeFromSuperview()
        self.viewController = viewController
        //添加控制器视图和布局
        if let view = self.viewController?.view{
            self.contentView.addSubview(view)
            view.snp.makeConstraints{make in
                make.edges.equalTo(0)
            }
        }
    }
}
