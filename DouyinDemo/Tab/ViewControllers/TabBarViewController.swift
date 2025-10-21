//
//  TabBarViewController.swift
//  DouyinDemo
//
//  Created by jiahong on 2025/10/20.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //首页
        let feedRootVC = FeedRootViewController()
        addChildViewController(childViewController: feedRootVC, title: "首页")
        
        //朋友
        let friendRootVC = FriendRootViewController()
        addChildViewController(childViewController: friendRootVC, title: "朋友")
        
        //相机
        let cameraRootVC = CameraRootViewController()
        let addImage = UIImage(named: "icon_home_add")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        addChildViewController(childViewController: cameraRootVC, title: nil, image: addImage, selectedImage: addImage)
        
        //消息
        let messageRootVC = MessageRootViewController()
        addChildViewController(childViewController: messageRootVC, title: "消息")
        
        //我的
        let profileRootVC = ProfileRootViewController()
        addChildViewController(childViewController: profileRootVC, title: "我的")
    }
    
    private func addChildViewController(childViewController:UIViewController, title:String?, image:UIImage?=nil, selectedImage:UIImage?=nil){
        let navigationController = UINavigationController(rootViewController: childViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        let tabBarItem = navigationController.tabBarItem
        tabBarItem?.title = title
        tabBarItem?.image = image
        tabBarItem?.selectedImage = selectedImage
        
        if let _ = title{
            //标题选中和未选中
            tabBarItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red, .font:UIFont.systemFont(ofSize: 15)], for: UIControl.State.normal)
            tabBarItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.blue, .font:UIFont.systemFont(ofSize: 15)], for: UIControl.State.selected)
            //设置间距
            tabBarItem?.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -25)
        }else{
            //图片
            tabBarItem?.imageInsets = UIEdgeInsets(top: 5.5, left: 0, bottom: -5.5, right: 0)
        }
        addChild(navigationController)
    }
}
