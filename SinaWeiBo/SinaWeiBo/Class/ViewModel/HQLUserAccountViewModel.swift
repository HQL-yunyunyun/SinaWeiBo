//
//  HQLUserAccountViewModel.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/14.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit

class HQLUserAccountViewModel: NSObject {
    
    
    // viewmodel是mvvc设计模式,将controller中得一些任务分离出来，如视图的数据---网络请求---数据库操作等，让controller专注于处理View布局、交互和动画，把任务剥离，降低整体项目的耦合性。
    
    // 来个单例---全局访问
    static let shareInstance: HQLUserAccountViewModel = HQLUserAccountViewModel()
    
    // 解档如归档的路径
    let userAccountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! + "/account.plist"
    
    /**
     *  全局访问点，只要访问这个属性，就可以知道用户的账号
     */
    var userAccount: HQLUserAccount?
    
    /**
        构造方法 直接加载账号
     */
    override init() {
        super.init()
        // 构造方法 直接加载账号
        userAccount = loadUserAccount()
    }
    
    
    /**
     *  获取token的方法 callback:回调方法
     */
    func loadAccessToken(code: String, callback:(error: NSError?) -> ()){
    
        // 截取到了code就开始请求 https://api.weibo.com/oauth2/access_token
        // 属性
        let parameters:[String: String] = [
            "client_id": client_id,
            "client_secret": client_secret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": redirect_uri
        ]
        
        HQLNetWorkTool.shareInstance.request(RequestMethod.POST, URLString: "https://api.weibo.com/oauth2/access_token", parameters: parameters, success: { (task, responseObject) in
            
            //获取到数据就把数据保存到沙盒当中
            // 拆包
            // 把respoObject转换成字典
            if let result: [String: AnyObject] = responseObject as? [String: AnyObject]{
                // 开始转换
                let account = HQLUserAccount(dict: result)
                
                // 在闭包中调用属性需要添加 self
                self.userAccount = account
                
                // 归档
                NSKeyedArchiver.archiveRootObject(account, toFile: self.userAccountPath)
                
                // 回调
                callback(error: nil)
                
            }else{
                // 转换失败 
                CZPrint(items: "转换失败")
                let errorString = NSError(domain: "字典转换失败", code: #line, userInfo: nil)
                callback(error: errorString)
            }
            
            
            }, failure: { (task, error) in
                callback(error: error)
        })
    }
    
    /**
     *  解档
     */
    func loadUserAccount() -> HQLUserAccount?{
        // 解档
        if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(userAccountPath) as? HQLUserAccount{
            // 加载到了账号, 判断是否过期
            // userAccount.expiresDate 和当前时间比较
            // NSDate(): 当前时间
            // userAccount.expiresDate < NSDate() 过期的
            // 测试:1.改系统时间 2.改userAccount.expiresDate属性,早期的时间
            //            userAccount.expiresDate = NSDate(timeIntervalSinceNow: -1000)
            
            if account.expires_date?.compare(NSDate()) != NSComparisonResult.OrderedAscending{
                // 没有过期
                return account
            }else{
                // 过期
                return nil
            }
        }else{
            // 解档失败
            return nil
        }
    }
}
