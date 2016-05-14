//
//  HQLConsant.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/12.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit

// 不是在类里面的代码,全局的
// 全局的打印方法,在debug模式下会输出,在release模式下不输出
/// 哪个文件,哪一行,哪个方法
func CZPrint(file: String = #file, line: Int = #line, function: String = #function, items: Any) {
    // 默认参数,如果调用的人不传递使用默认参数
    // Swift在DEBUG模式下并没有这个宏, 需要自己手动配置 buildSetting -> 搜索 swift flag,在DEBUG模式下配置 -D DEBUG
    #if DEBUG
        print("文件: \((file as NSString).lastPathComponent), 行数: \(line), 函数: \(function): => \(items) \n")
    #endif
}

 /// 全局的背景颜色
let GlobalBKColor: UIColor = UIColor.whiteColor()

/// 网址：https://api.weibo.com/oauth2/authorize
let oauthURLString = "https://api.weibo.com/oauth2/authorize"

/// 申请应用的id 4291339252
let client_id = "4291339252"

/// 密码 申请应用时分配的AppSecret
let client_secret = "399defe2546b1b78d601717e56a7e98c"

/// 回调网址
let redirect_uri = "http://www.baidu.com"