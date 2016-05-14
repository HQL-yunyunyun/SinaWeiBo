//
//  HQLOauthViewController.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/13.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit
import SVProgressHUD

 /// 授权控制器

class HQLOauthViewController: UIViewController {
    
    // ==================MARK: - 生命周期方法
    
    override func loadView() {
        super.loadView()
        self.view = webView
        webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            ///  设置背景颜色  如果没有设置背景颜色，则webView的背景是透明的
        webView.backgroundColor = GlobalBKColor
        
        // 设置属性
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "填充", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(autoFill))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(close))
        // title
        navigationItem.title = "登录"
        
        // 设置webviwe
        let urlString = oauthURLString + "?client_id=" + client_id + "&redirect_uri=" + redirect_uri
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
        CZPrint(items: "urlString: \(urlString)")
        // 加指示器,显示正在加载
        // SVProgressHUD.showErrorWithStatus(status: String!) 显示错误
        //        SVProgressHUD.showInfoWithStatus("正在加载") // 提示信息感叹号,会自动关闭
        //SVProgressHUD.showWithStatus("正在加载")    // 进度形式,如果不主动关闭,会一直存在
        SVProgressHUD.showWithStatus("拼命加载中。。。")
    }
    
    
    
    // ==================MARK: - 点击方法
    /**
        填充方法
     */
    @objc private func autoFill()
    {
        // 填充
        // 使用js方式调用
        let jsString: String = "document.getElementById('userId').value = '13710206436';document.getElementById('passwd').value = 'He20131101caiyun';"
        
        webView.stringByEvaluatingJavaScriptFromString(jsString)
    }
    
    /**
        关闭
     */
    @objc private func close(){
        // 关闭
        SVProgressHUD.dismiss()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // ==================MARK: - 懒加载
    private lazy var webView: UIWebView = UIWebView()
    
   

}

// MARK: - UIWebViewDelegate
extension HQLOauthViewController: UIWebViewDelegate{
    
    // 加载完时结束
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    // webView加载网页的时候回调用这个方法,加载一次回调一次,询问我们是否要加载某个请求
    // return true可以加载这个界面
    // teturn false就不加载
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 取得回调地址 根据地址来判断授权是否成功
        let url = request.URL!
        
        /**
         *  回调地址，只要是在登录页面，有回调的话，都会调用我们的回调地址 如果授权成功会在回调地址的query上添加code属性
         */
        if !url.absoluteString.hasPrefix(redirect_uri){
            // 不是回调地址就是新浪的地址 -> 继续走下去
            return true
        }else {
            // 是回调地址 判断是否授权成功
            // 直接获取query的属性
            let query = url.query!
            
            // 判断是否为code开头
            let codeString = "code="
            // 判断query的前缀是否为code=
            if query.hasPrefix(codeString){
                // 是则截取code=后面的值
                // swift中得String类型，获取长度需要：对象.characters.count
                let code = (query as NSString).substringFromIndex(codeString.characters.count)
                
                HQLUserAccountViewModel.shareInstance.loadAccessToken(code, callback: { (error) in
                    if error != nil{
                        // 出现了错误
                        CZPrint(items: "出现了错误: \(error)")
                        SVProgressHUD.showErrorWithStatus("您的网络不给力...")
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { 
                            // 延迟一秒后关闭
                            self.close()
                        })
                    }else{
                        // 没有错误
                        self.close()
                        CZPrint(items: HQLUserAccountViewModel.shareInstance.userAccount)
                    }
                })
                return true
            }
            else{
                // 不是，则关闭
                self.close()
                return false
                
            }
        }
    }
}
