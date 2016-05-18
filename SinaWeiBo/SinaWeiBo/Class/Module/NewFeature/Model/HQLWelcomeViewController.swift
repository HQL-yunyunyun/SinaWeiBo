//
//  HQLWelcomeViewController.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/14.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class HQLWelcomeViewController: UIViewController {
    
    // ==================MARK: - 生命周期方法
    
    override func viewDidLoad() {
        // 加载控件
        super.viewDidLoad()
        
        self.prepareUI()
        
        // 即使头像在本地缓存了图片,刚开始会用占位图片,只有网路请求完成后才会使用SDWebImage设置图片
        // 解决方法,在获取用户信息之前,也使用SDWebImage去设置一下头像的图片
        setIcon()
        
        // 获取用户信息
        HQLUserAccountViewModel.shareInstance.loadUserInfo { 
            self.setIcon()
        }
        
    }
    
    // 获取头像
    private func setIcon(){
        if let avatar_large = HQLUserAccountViewModel.shareInstance.userAccount?.avatar_large{
            // 获取到用户数据
            let url = NSURL(string: avatar_large)
            self.iconView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar_default_big"))
        }
    }
    
    // 在这个方法----视图已经显示----这样动画才会动
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 调用动画
        self.moveAnimation()
    }
    
    // ==================MARK: - 类的私有方法
    // 动画
    private func moveAnimation(){
        // 移动动画
        // 弹簧动画
        // usingSpringWithDamping: 弹簧的明显程度 0 - 1
        // initialSpringVelocity: 初始速度
        
        UIView.animateWithDuration(2, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { 
            // 动画
            // 更新约束
            self.iconView.snp_updateConstraints(closure: { (make) in
                 make.bottom.equalTo(self.view).offset(-(UIScreen.mainScreen().bounds.height - 160))
            })
            
            // 更新约束后调用这个方法  Lays out the subviews immediately. 重新布局
            self.view.layoutIfNeeded()
            
            }) { (_) in
                CZPrint(items: "弹簧动画完成, label渐变动画")
                UIView.animateWithDuration(0.5, animations: {
                    // 显示label
                    self.messageLabel.alpha = 1
                    }, completion: { (_) in
                        
                        // 显示完就直接跳转
                         let appdelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                        // 把window的根控制器替换成tabBarController
                        appdelegate.switchRootViewController(HQLTabBarController())
                })
        }
    }
    
    // 加载控件
    private func prepareUI(){
        self.view.addSubview(bgView)
        self.view.addSubview(iconView)
        self.view.addSubview(messageLabel)
        
        // 设置约束
        // autolayout
        // 背景
        // bkgView: 要添加约束的view
        // snp_makeConstraints: 要添加约束
        // make: 要添加约束的view
        bgView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        // 头像
        iconView.snp_makeConstraints { (make) in
            // make.centerX: 要约束view的centerX属性
            // equalTo: 参照
            // self.view: 参照的view
            // snp_centerX: 参照View的哪个属性, 参照view的属性需要添加snp_make.centerX.equalTo(self.view.snp_centerX)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-160)
        }
        
        // 消息
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp_bottom).offset(16)
        }
    }
    // ==================MARK: - 懒加载控件
    // 背景
    private lazy var bgView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    // 头像
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar_default_big"))
        
        // 圆角
        imageView.layer.cornerRadius = 42.5
        // 实现这个属性才会有圆角
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    // label控件
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        
        // 设置label属性
        label.text = "欢迎回来"
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(15)
        label.sizeToFit()
        
        return label
    }()
}
