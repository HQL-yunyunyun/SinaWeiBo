//
//  HQLConsant.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/12.
//  Copyright © 2016年 HQL. All rights reserved.
//

import Foundation

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