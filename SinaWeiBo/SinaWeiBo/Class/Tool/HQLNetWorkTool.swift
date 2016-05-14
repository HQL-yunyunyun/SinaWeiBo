//
//  HQLNetWorkTool.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/13.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit
import AFNetworking

// 请求方法枚举
enum RequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class HQLNetWorkTool: NSObject {

    
    // 单例
    static let shareInstance: HQLNetWorkTool = HQLNetWorkTool()
    
    // afnsession属性
    private let afnManage: AFHTTPSessionManager = {
        let afn = AFHTTPSessionManager(baseURL: NSURL(string: "https://api.weibo.com/"))
        
        // 给解析器添加 "text/plain" 类型 acceptableContentTypes 是 NSSet 集合，直接用insert 方法添加
        afn.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return afn
    }()
    
    // 封装方法
    // 如果直接使用AFN的GET和POST方法,如果AFN改变了方法名或参数改变了,哪项目中直接使用AFN.GET和POST的地方都需要改变
    // 自己封装GET 和 POST方法,项目中要使用GET和POST就用我们封装好的,到时如果如果AFN改变了方法名或参数改变了,只需要改我们封装的方法
    /// 封装AFN的GET和POST,通过参数来确定使用GET还是POST

    func request(method: RequestMethod, URLString: String,parameters: AnyObject?, success: ((NSURLSessionDataTask, AnyObject?) -> Void)?, failure: ((NSURLSessionDataTask?, NSError) -> Void)?){
        if  method ==  RequestMethod.GET{
            afnManage.GET(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else if method == RequestMethod.POST{
            afnManage.POST(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
