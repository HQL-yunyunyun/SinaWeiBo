//
//  HQLStatus.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/18.
//  Copyright © 2016年 HQL. All rights reserved.
//

import Foundation

class HQLStatus: NSObject {
    
    // ==================MARK: - 属性
    
    // 微博创建时间
    var created_at: String?
    
    // 微博id
    var id: Int64 = 0
    
    // 微博内容
    var text: String?
    
    // 微博来源
    var source: String?
    
    // 转发数
    var reposts_count: Int = 0
    
    /// 评论数
    var comments_count: Int = 0
    
    /// 表态数
    var attitudes_count: Int = 0
    
    /// 微博配图: 数组里面是字典 // Int类型的数组[Int], 字典类型的数组 [String: AnyObject] -> [[String: AnyObject]]
    var pic_urls: [[String: AnyObject]]?
    
    /// 用户模型
    var user: HQLUser?
    
    // ==================MARK: - 构造函数
    init(dict: [String: AnyObject]){
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    // 调用这个方法 重写了这个方法，系统就不会自动帮我们赋值
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
            // 字典转模型
            if let dict = value as? [String: AnyObject] {
                // 转模型
                user = HQLUser(dict: dict)
            }
            
            // 一定要记得return,不然会不给super.setValue:forKey:给覆盖成字典
            return
        }
        super.setValue(value, forKey: key)
    }
    // 找不到的属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {return}
    /// 对象打印
    override var description: String {
        get {
            
            // 使用每一个key去模型中找到值,使用key和找到的值,拼接成字典
            // keys是字典的key
            let keys = ["created_at", "id", "text", "source", "reposts_count", "comments_count", "attitudes_count", "pic_urls", "user"]
            
            return "\n \t 微博模型: \(dictionaryWithValuesForKeys(keys))"   // \n 换行 \t table
        }
    }
}
