//
//  HQLTabBarController.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/10.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit


 ///  自定义tabBarController

class HQLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSubview()
    }
    
    // 设置tabBar子视图
    func setupSubview(){
        
        // home
        let home = HomeController()
        self.addChildViewController(home, title: "首页", imageName: "tabbar_home")
        
        // 消息
        let message = MessageController()
        self.addChildViewController(message, title: "消息", imageName: "tabbar_message_center")
        
        // 发现
        let discovery = DiscoveryController()
        self.addChildViewController(discovery, title: "发现", imageName: "tabbar_discover")
        
        // 我
        let profile = ProfileController()
        self.addChildViewController(profile, title: "我", imageName: "tabbar_profile")
    }
    
    func addChildViewController(controller: UIViewController, title: String, imageName: String) {
        // 设置title 同时设置tabBar的title 和 navigation的title
        // -> controller.tabBarItem.title + controller.navigationItem.title
        controller.title = title;
        // 设置图片
        controller.tabBarItem.image = UIImage(named: imageName);
        // 设置选中图片  imageWithRenderingMode->使用渲染模式，三种渲染模式
        /**
         case Automatic // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
         
         case AlwaysOriginal // 始终绘制图片原始状态，不使用Tint Color。
         case AlwaysTemplate // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
         */
        // 这两个的效果可以用一句代码代替 tabBar.tintColor = UIColor.orangeColor()
        // 所有的tabBar的颜色都为一种颜色，不利于自定义
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        // 设置选中时字体的颜色
        controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orangeColor()], forState: UIControlState.Selected)
        // 包装导航器 swift 可以忽略self
        addChildViewController(UINavigationController(rootViewController: controller))
        
        
    }
    
}
