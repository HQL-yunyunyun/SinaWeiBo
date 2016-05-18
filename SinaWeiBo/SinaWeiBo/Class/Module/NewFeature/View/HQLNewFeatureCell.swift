//
//  HQLNewFeatureCell.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/15.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit

class HQLNewFeatureCell: UICollectionViewCell {
    
    // ==================MARK: - 属性 property
    var index: Int = 0{
        didSet{
            // 当index改变的时候，就改变图片
            bkgImageView.image = UIImage(named: "new_feature_\(index + 1)")
            
            startButton.hidden = true
        }
    }
    
    // ==================MARK: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ==================MARK: - 私有方法
    
    // button的动画
    func startAnimation(){
        // 动画之前,将按钮显示出来
        startButton.hidden = false
        // 在动画开始前，将transform.scale设置为0这样button就不会显示出来
        startButton.transform = CGAffineTransformMakeScale(0, 0)
        
        // 动画 弹簧效果
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { 
                self.startButton.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    }
    // 设置控件
    private func prepareUI(){
        contentView.addSubview(bkgImageView)
        contentView.addSubview(startButton)
        
        // 设置约束
        bkgImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        startButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-160)
        }
    }
    // 点击事件
    @objc private func startButtonDidClick(){
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.switchRootViewController(HQLWelcomeViewController())
    }
    
    // ==================MARK: - 懒加载
    // 背景
    private lazy var bkgImageView: UIImageView = UIImageView(image: UIImage(named: "new_feature_1"))
    // 按钮
    private lazy var startButton: UIButton = {
        let button = UIButton()
        // 设置属性
        button.setTitle("点击开始奇妙之旅", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        button.hidden = true
        // 点击事件
        button.addTarget(self, action: #selector(startButtonDidClick), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    
}
