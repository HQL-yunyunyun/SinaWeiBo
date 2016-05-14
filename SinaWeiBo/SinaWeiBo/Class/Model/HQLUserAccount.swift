//
//  HQLUserAccount.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/14.
//  Copyright © 2016年 HQL. All rights reserved.
//

import Foundation

// 对象归档和解档
// 1.对象遵守NSCoding协议:知道对象要保存和解档哪些属性
// 2.调用归档和解档的方法

class HQLUserAccount: NSObject, NSCoding {
    
    // ==================MARK: - 属性propery
     /// token用户授权的唯一票据
    var access_token: String?
    /// access_token的生命周期，单位是秒数, 基本数据类型不能使用?,KVC会找不到
    var expires_in: NSTimeInterval = 0{
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
     /// 剩余时间-- date 模式
    var expires_date: NSDate?
    
     /// 用户标识
    var uid: String?
    
    /**
        构造方法
     */
    init(dict: [String: AnyObject]) {
        // 要先创建对象
        super.init()
        // kvc赋值
        // 对象创建好后才能使用对象的方法, 内部会调用setValue(value: AnyObject?, forKey key: String),每次拿一个key和value调用一次
        self.setValuesForKeysWithDictionary(dict)
    }
    
    // 当setValue:forKey:找不到key时会调用setValue:forUndefinedKey:.如果不实现setValue:forUndefinedKey:就会报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        CZPrint(items: "forUndefinedKey \(key)")
    }
    // 打印方法 description属性
    override var description: String{
        get{
             return "用户账户: access_token: \(access_token), expires_in: \(expires_in), uid: \(uid), expiresDate: \(expires_date)"
        }
    }
    
    
    // MARK: - 解档---归档
    // 解档
    required init?(coder aDecoder: NSCoder) {
        
        // 因为解档的decodeObjectForKey方法返回的时一个 AnyObject? 的对象， 所以这里需要用as来转换类型
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        uid = aDecoder.decodeObjectForKey("uid") as? String
    }
    
    // 归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(uid, forKey: "uid")
    }
    
}

