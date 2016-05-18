//
//  HQLUser.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/18.
//  Copyright © 2016年 HQL. All rights reserved.
//

import Foundation

class HQLUser: NSObject {
    
    // ==================MARK: - 属性
    /// 用户UID
    var id: Int64 = 0
    
    /// 用户昵称
    var screen_name: String?
    
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    
    /// verified_type 没有认证:-1   认证用户:0  企业认证:2,3,5  达人:220
    var verified_type: Int = -1
    
    /// 会员等级 1-6
    var mbrank: Int = 0
    
    // ==================MARK: - 构造方法
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {return}

    override var description: String {
        get {
            let keys = ["id", "screen_name", "profile_image_url", "verified_type", "mbrank"]
            
            return "\n \t \t用户模型: \(dictionaryWithValuesForKeys(keys))"
        }
    }

}
