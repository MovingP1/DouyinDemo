//
//  FeedRootViewController.swift
//  DouyinDemo
//
//  Created by jiahong on 2025/10/20.
//

import UIKit
import SnapKit

class FeedRootViewController: UIViewController,FeedContainerViewControllerDelegate,FeedTabViewDelegate {
    
    private var containerVC: FeedContainerViewController!
    private var tabView: FeedTabView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化ContainerVC
        containerVC = FeedContainerViewController()
        //设置代理
        containerVC.delegate = self
        addChild(childViewController: containerVC){subview in
            subview.snp.makeConstraints{make in
                make.leading.trailing.top.equalTo(self.view)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
            }
        }
        //添加TabView并布局
        tabView = FeedTabView(items: [.init(index: 0, title: "推荐"), .init(index: 1, title: "关注")], delegate: self)
        view.addSubview(tabView)
        tabView.snp.makeConstraints{maker in
            maker.centerX.equalTo(self.view)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.width.equalTo(150)
            maker.height.equalTo(40)
        }
    }
    
    //Mark FeedContainerViewControllerDelegate
    func feedContainerViewController(controller:FeedContainerViewController, viewControllerAt indexPath: IndexPath)->UIViewController{
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.randomColor
        return vc
    }
    
    func numberOfViewControllers(in containerViewController:FeedContainerViewController)->Int{
        return 2
    }
    
    func feedContainerViewController(controller:FeedContainerViewController, didScroll scrollView:UIScrollView){
        //滚动视图宽和位置
        let pageWidth = scrollView.frame.width
        let contentOffsetX = scrollView.contentOffset.x
        guard pageWidth > 0 else{
            return
        }
        //滚动进度=当前位置/宽度
        let progress = contentOffsetX / pageWidth
        tabView.updateSelectedIndex(with: progress)
    }
    //Mark FeedTabViewDelegate
    func didSelect(item:FeedTabView.Item, in tabView:FeedTabView){
        containerVC.setPageIndex(index: item.index, animated: true)
    }
}
