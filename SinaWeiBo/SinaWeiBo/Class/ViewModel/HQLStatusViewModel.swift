//
//  HQLStatusViewModel.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/18.
//  Copyright © 2016年 HQL. All rights reserved.
//

import Foundation

class HQLStatusViewModel: NSObject {

    // 单例
    static let shareInstance: HQLStatusViewModel = HQLStatusViewModel()
    
    // ==================MARK: - 构造方法
    /// 私有构造函数 这样就只能调用单例
    private override init() {
        super.init()
    }
    
    // ==================MARK: - 加载微博数据 
    /**
        闭包返回的是微博数组
     */
    func loadStatus(loadStatusCallBack:(status: [HQLStatus]?, error: NSError?) -> ()){
        // 判断token是否为空
        guard let access_token = HQLUserAccountViewModel.shareInstance.userAccount?.access_token else{
            let error = NSError(domain: "token为空", code: #line, userInfo: nil)
            loadStatusCallBack(status: nil, error: error)
            return
        }
        // 参数
        let urlString = "2/statuses/friends_timeline.json"
        
        let parameters = [
            "access_token": access_token
        ]
        
        // 请求
        HQLNetWorkTool.shareInstance.request(RequestMethod.GET, URLString: urlString, parameters: parameters, success: { (_, responseObject) in
            // 转字典
            var error = NSError(domain: "数据转换失败", code: #line, userInfo: nil)
            
            guard let dict = responseObject as? [String: AnyObject] else{
                // 转失败
                loadStatusCallBack(status: nil, error: error)
                return
            }
            // 转成功 -> 微博字典转换
            guard let statusDict = dict["statuses"] as? [[String: AnyObject]] else{
                // 微博字典转换失败
                error = NSError(domain: "微博字典转换失败", code: #line, userInfo: nil)
                loadStatusCallBack(status: nil, error: error)
                return
            }
            
            // 表明转换成功
            var statusArray = [HQLStatus]()
            
            // 开始转换
            for statuDict in statusDict {
                // 开始转换
                let statu = HQLStatus(dict: statuDict)
                statusArray.append(statu)
            }
            // 将微博数据告诉homeViewController(调用的人) 转换完
            loadStatusCallBack(status: statusArray, error: nil)
            
            }) { (_, error) in
                loadStatusCallBack(status: nil, error: error)
        }
    }
}
