//
//  FeedTabView.swift
//  DouyinDemo
//
//  Created by jiahong on 2025/10/21.
//

import Foundation
import UIKit
import SwiftUI

protocol FeedTabViewDelegate:NSObjectProtocol{
    func didSelect(item:FeedTabView.Item, in tabView:FeedTabView)
}

//自定义导航栏
class FeedTabView:UIView {
    //结构体,描述每个条目的信息
    struct Item {
        var index:Int
        var title:String
    }
    
    private var items:[Item] = []
    private var buttons:[UIButton] = [UIButton]()
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var bottomLine:UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return line
    }()
    private var selectedIndex:Int = 0
    //代理属性
    public weak var delegate:FeedTabViewDelegate?
    
    init(items:[Item], delegate:FeedTabViewDelegate){
        self.items = items
        self.delegate = delegate
        super.init(frame: CGRect.zero)
        //传入的items映射成按钮
        self.buttons = self.items.map({item in
            return self.createButton(item: item)
        })
        //按钮添加到视图容器
        self.buttons.forEach{button in
            self.stackView.addArrangedSubview(button)
        }
        //把容器加到视图上
        addSubview(stackView)
        addSubview(bottomLine)
        updateSelectedIndex(with: 0)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //导航栏
    override func layoutSubviews() {
        super.layoutSubviews()
        //frame设置成当前视图尺寸
        stackView.frame = bounds
        updateSelectedIndex(with: CGFloat(selectedIndex))
    }
    public func updateSelectedIndex(with progress:CGFloat){
        //更新bottomLine宽度
        let buttonWidth = bounds.width / CGFloat(items.count)
        var frame:CGRect = CGRect.zero
        frame.size = CGSize(width: 20, height: 4)
        frame.origin.y = bounds.height - frame.size.height//放在最下
        frame.origin.x = (buttonWidth - frame.width)/2 + buttonWidth*progress
        bottomLine.frame = frame
        
        selectedIndex = Int(round(progress))
        //更改按钮选中状态
        for i in 0..<buttons.count{
            let button = buttons[i]
            button.isSelected = (i == selectedIndex)
        }
    }
    
    //创建按钮
    private func createButton(item: Item) -> UIButton{
        let button = UIButton(type: .custom)
        button.setTitle(item.title, for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5), for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .highlighted)
        button.addTarget(self, action: #selector(didTap(button:)), for: .touchUpInside)
        return button
    }
    
    //点击事件
    @objc private func didTap(button:UIButton){
        guard let index = buttons.firstIndex(of: button), index < items.count else{
            return
        }
        delegate?.didSelect(item: items[index], in: self)
    }
}
