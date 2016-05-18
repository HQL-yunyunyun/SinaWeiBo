//
//  HomeController.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/10.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit

class HomeController: BaseTableViewController {

    // ==================MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        // 设置两个button
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch", target: self, action: #selector(didClickFriendsearch))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(didClickPop))
        
        // 设置标题按钮
        let button = HQLHomeTitleButton()
        // ?? 的作用就是判断前面的值是否为空，如果为空，则等于后面的值
        let name = HQLUserAccountViewModel.shareInstance.userAccount?.screen_name ?? "未知名称"
        button.setTitle(name, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(16)
        button.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(didClickTitleView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.sizeToFit()
        navigationItem.titleView = button
    }

    // ==================MARK: - 点击方法
    
    @objc private func didClickTitleView(button: UIButton) {
        button.selected = !button.selected
        
        // 动画
        UIView.animateWithDuration(0.25) { 
            let transfrom = button.selected ? CGAffineTransformMakeRotation(CGFloat(M_PI - 0.000001)) : CGAffineTransformIdentity
            
            button.imageView?.transform = transfrom
        }
    }
    
    @objc private func didClickFriendsearch() {
        print("点击了朋友")
    }
    @objc private func didClickPop() {
        print("点击了扫一扫")
    }
}
