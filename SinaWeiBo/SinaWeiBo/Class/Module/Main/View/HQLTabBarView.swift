//
//  HQLTabBarView.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/10.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit

class HQLTabBarView: UITabBar {

    /**
     *  自定义一个UITabBa
     *  在layoutsubview的方法中遍历子控件，然后再改变frame值
     */
    
    // ==================MARK: - 属性定义
    // button点击回调闭包 没有属性，没有返回值的闭包
    var composeCallback: (() -> ())?
    
    // ==================MARK: - 生命周期方法
    override func layoutSubviews() {
        super.layoutSubviews()
        // 遍历子控件
        // 定义一个index来记录，view的frame值与顺序有关系
        var index = 0
        // 宽度
        let width = self.frame.width / 5
        for view in subviews{
            print(view)
            // 判断view的类型
            // UITabBarButton是系统隐藏的类 无法调用这个类的方法 [UITabBarButton class]
            // NSClassFromString("UITabBarButton") = [UITabBarButton class]
            // ！强制拆包 -> 一定得有值才可以判断
            if view.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                view.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: self.frame.height)
                index += 1
                if index == 2 {
                    index += 1
                }
            }
        }
        // 设置button的值
        composeButton.frame = CGRect(x: 2 * width, y: 0, width: width, height: self.frame.height)
    }
    // ==================MARK: - 绑定方法
    @objc private func composeButtonClick(button: UIButton) -> (){
    
//        print("点击了我")
        /*
         因为这里是view，而这个按钮点击事件需要modal一个控制器出来，view是没有这个方法的
         再者在mvc中说，这个modal控制器应该交给控制器来做,所以这里可以用delegate或者闭包
         */
        // 调用闭包
        // 不用跟oc一样判断是否为空，？就代表可以为空，如果为空则什么都不做
        self.composeCallback?()
        
    }
    
    // ==================MARK: - 懒加载
    lazy var composeButton: UIButton = {
        // 创建按钮
        let button = UIButton(type: UIButtonType.Custom)
        
        // 设置背景图片
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        // 设置按钮图片
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        // 绑定事件
        // selectior 可以用字符串
        button.addTarget(self, action: #selector(HQLTabBarView.composeButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // selector在swift中需要这样：类.方法(参数)
//        button.addTarget(self, action: #selector(HQLTabBarView.composeButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // 添加到view中
        self.addSubview(button)
        
        return button
    }()

}
