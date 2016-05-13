//
//  visitorView.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/12.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit


// ==============MARK: - 定义协议 @objc protocol 协议名: NSObjectProtocol
@objc protocol visitorViewDelegate: NSObjectProtocol{
    // 定义方法  如果前缀没有修饰 optional 则所有方法都是 required 的
    func visitorViewDidClickLogin()
    
    func visitorViewDidClickRegister()
    
}

class visitorView: UIView {
    // 加载页面 -- 加载控件 -- 控件使用懒加载的方式
    
     // ==================MARK: - 属性
    weak var delegate: visitorViewDelegate?
    
    // ==================MARK: - 公开的方法 -- 转轮 -- 设置不同的view
    /// 设置访客视图内容
    func setupVisitorInfo(imageName: String, message: String){
        self.iconView.image = UIImage(named: imageName)
        self.messageLabel.text = message
        self.coverView.hidden = true
        self.homeView.hidden = true
    }
    
    func startRotationAnimation(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = M_PI * 2
        anim.repeatCount = MAXFLOAT
        anim.duration = 25
        
        // 核心动画完成时不会自动移除
        anim.removedOnCompletion = false
        
        iconView.layer.addAnimation(anim, forKey: nil)
    }
    
    // ==================MARK: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 在这个方法中添加子控件
        self.prepareUI()
    }
    // 这个方法是view重写构造方法必须实现的
    // 因为switf的语法中，如果重写了构造函数，则
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ==================MARK: - prepare -- 设置子控件
    private func prepareUI(){
        
        // 设置背景颜色
//        self.backgroundColor = UIColor(red: 233 / 255.0, green: 233 / 255.0, blue: 233 / 255.0, alpha: 1)
        self.backgroundColor = UIColor(white: 237 / 255.0, alpha: 1)
        
        
        // 添加控件
        self.addSubview(iconView)
        self.addSubview(coverView)
        self.addSubview(homeView)
        self.addSubview(messageLabel)
        self.addSubview(registerButton)
        self.addSubview(loginButton)
        
        // 如果是用代码添加约束，则需要将translatesAutoresizingMaskIntoConstraints这个属性设置为false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        coverView.translatesAutoresizingMaskIntoConstraints = false
        homeView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 开始添加约束
        // 约束要添加到控件的父控件上面
        // item: 要添加约束的view
        // attribute: 要添加的View的属性
        // toItem: 要参照的view
        // attribute: 要参照View的属性
        // 将约束添加到view上面去
        
        // 轮子
        self.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -40))
        
        // 遮盖
        self.addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        
        // 小房子
        // CenterX转轮CenterX
        self.addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        // CenterY转轮CenterY
        self.addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        // 消息label
        /// 宽度
        /// 当参照的view为nil时,属性为NSLayoutAttribute.NotAnAttribute
        self.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 240))
        // CenterX 和父控件CenterX
        self.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        // Top和转轮底部
        self.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        
        // 注册按钮
        /// 顶部和label底部
        self.addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        /// 左边和label对齐
        self.addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        /// 宽度
        self.addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        // 高度
        self.addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))
        
        // 登录按钮
        /// 顶部和label底部
        self.addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        /// 右边和label对齐
        self.addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        /// 宽度
        self.addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        // 高度
        self.addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))
        
    }
    
    
        // ==================MARK: - 点击事件
    // 按钮点击事件方法是系统来调用, 当把按钮点击事件private后系统就找不到这个方法了
    // @objc: 让系统可以找到我们的方法
    @objc private func registerBtnClick(){
        // view不能Modal出控制器来,需要将事件传递给控制器
        self.delegate?.visitorViewDidClickRegister()
    }
    @objc private func loginBtnClick(){
        self.delegate?.visitorViewDidClickLogin()
    }
    
        // ==================MARK: - 懒加载控件
    // 转轮
    lazy private var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // 遮罩 -- 渐变隐形的一般用一个遮罩的view来实现
    lazy private var coverView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    // 小房子
    lazy private var homeView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // 文字  如果想在定义的时候定义多个属性，可以用这种方式={...}() 的方式来实现
    lazy private var messageLabel:UILabel = {
        let label:UILabel = UILabel()
        
        // 设置属性
        label.text = "关注一些人,看看有什么惊喜!"
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(16)
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0;
        label.sizeToFit()
        
        return label
    }()
    // 注册按钮
    lazy private var registerButton:UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        
        // 设置属性
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        button.setTitle("注册", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(visitorView.registerBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }()
    
    // 登录按钮
    lazy private var loginButton:UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        
        // 设置属性
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setTitle("登录", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(visitorView.loginBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }()

}
