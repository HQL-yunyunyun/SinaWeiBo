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
    
    // ==================MARK: - 属性 + 方法
    
    // 来个单例---全局访问
    static let shareInstance: HQLUserAccountViewModel = HQLUserAccountViewModel()
    
    // 解档如归档的路径
    let userAccountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! + "/account.plist"
    
    /**
     *  全局访问点，只要访问这个属性，就可以知道用户的账号
     */
    var userAccount: HQLUserAccount?
    
    /**
        设置一个属性-> 是否登录
     */
    var isUserLogin: Bool{
        get{
            // 是否登录
            return userAccount != nil
        }
    }
    
    // ==================MARK: - 构造方法
    
    /**
        构造方法 直接加载账号
     */
    override init() {
        super.init()
        // 构造方法 直接加载账号
        userAccount = loadUserAccount()
    }
    
    // ==================MARK: - 获取token
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
            /*
                可选绑定  可选绑定会造成嵌套层次太多
             if let test = 值? {
                test 操作
             }
             */
            
            if let result: [String: AnyObject] = responseObject as? [String: AnyObject]{
                // 开始转换
                let account = HQLUserAccount(dict: result)
                
                // 在闭包中调用属性需要添加 self
                self.userAccount = account
                
                // 归档
                self.saveUserAccount()
                
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
    
    // 保存到沙盒当中 保存当前全局的账号
    private func saveUserAccount(){
        if let account = userAccount{
            NSKeyedArchiver.archiveRootObject(account, toFile: self.userAccountPath)
        }
    }
    
    // ==================MARK: - 获取用户名称和头像
    func loadUserInfo(loadUserInfoCallBack:() -> ()){
        // 可选绑定会造成嵌套层次很多, swift提供了另外一种形式,守卫 guard
        // guard正好相反
        // 判断token是否有值
        guard let access_token = userAccount?.access_token else {
            CZPrint(items: "token没有值")
            return
        }
        guard let uid = userAccount?.uid else {
            CZPrint(items: "uid没有值")
            return
        }
        // 到这个地方，token和uid都由值
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parametes = [
            "access_token": access_token,
            "uid": uid
        ]
        CZPrint(items: "\(parametes)")
        
        // 请求
        HQLNetWorkTool.shareInstance.request(RequestMethod.GET, URLString: urlString, parameters: parametes, success: { (_, responseObject) in
            // 获取信息 转换成字典
            if let result = responseObject as? [String: AnyObject]{
                let screen_name = result["screen_name"] as? String
                let avatar_large = result["avatar_large"] as? String
                
                // 赋值到当前账号
                self.userAccount?.screen_name = screen_name
                self.userAccount?.avatar_large = avatar_large
                
                self.saveUserAccount()
                loadUserInfoCallBack()
            }else{
                CZPrint(items: "获取用户数据失败")
            }
            
            }) { (_, error) in
                CZPrint(items: "获取用户信息出错:\(error)")
        }
    }
    
    // ==================MARK: - 解档
    
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
