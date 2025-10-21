//
//  UIViewController+Douyin.swift
//  DouyinDemo
//
//  Created by jiahong on 2025/10/21.
//  做扩展一般用类名+扩展命名

import Foundation
import UIKit

extension UIViewController {
    //为当前布局添加子布局加闭包
    func addChild(childViewController:UIViewController?, layout:(_ view:UIView) -> Void){
        //判断childVC是否合法
        guard let childviewController = childViewController else{
            return
        }
        //为自己视图添加子控制器视图
        view.addSubview(childviewController.view)
        addChild(childviewController)
        childviewController.didMove(toParent: self)
        //设置好层级关系后调用闭包
        layout(childviewController.view)
    }
}
