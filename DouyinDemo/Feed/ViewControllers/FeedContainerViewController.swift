//
//  FeedContainerViewController.swift
//  DouyinDemo
//
//  Created by jiahong on 2025/10/20.
//

import UIKit
import SnapKit//自动布局库

protocol FeedContainerViewControllerDelegate:NSObjectProtocol{
    //返回对应位置控制器
    func feedContainerViewController(controller:FeedContainerViewController, viewControllerAt indexPath: IndexPath)->UIViewController
    //返回总控制器个数
    func numberOfViewControllers(in containerViewController:FeedContainerViewController)->Int
    //滑动视图
    func feedContainerViewController(controller:FeedContainerViewController, didScroll scrollView:UIScrollView)
}

class FeedContainerViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    //代理熟悉,weak避免循环引用
    public weak var delegate:FeedContainerViewControllerDelegate?
    
    private var collectionView: UICollectionView!
    private var collectionViewLatout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewLatout = UICollectionViewFlowLayout()
        collectionViewLatout.scrollDirection = .horizontal
        collectionViewLatout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLatout)
        collectionView.contentInsetAdjustmentBehavior = .never//不自动调整
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedContainerCollectionViewCell.self, forCellWithReuseIdentifier: FeedContainerCollectionViewCell.reuseIdentifierString)
        collectionView.isPagingEnabled = true//可以分页
        collectionView.showsHorizontalScrollIndicator = false//隐藏横滚动条
        
        view.addSubview(collectionView)
        
        //collectionView与父视图四条边距为0
        collectionView.snp.makeConstraints{
            make in make.edges.equalTo(0)
        }
    }
    
    public func setPageIndex(index: Int, animated: Bool){
        guard index < collectionView.numberOfItems(inSection: 0) else{
            return
        }
        collectionView.setContentOffset(CGPoint(x: CGFloat(index)*collectionView.frame.width, y: 0), animated: animated)
    }
    
    //Mark UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    //Mark UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return delegate?.numberOfViewControllers(in: self) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //通过Collection的DQ方法初始化cell可以重用
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedContainerCollectionViewCell.reuseIdentifierString,
                                                      for: indexPath)as!FeedContainerCollectionViewCell
        //通过代理方法拿到controller
        if let viewController = delegate?.feedContainerViewController(controller: self, viewControllerAt: indexPath){
            //调用cell的config设置新的VC
            cell.config(with: viewController)
        }
        cell.backgroundColor = UIColor.randomColor
        return cell
    }
    //Mark UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //传递当前滚动消息
        delegate?.feedContainerViewController(controller: self, didScroll: scrollView)
    }
}
