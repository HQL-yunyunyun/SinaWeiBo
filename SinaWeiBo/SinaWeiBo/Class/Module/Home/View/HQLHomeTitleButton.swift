//
//  HQLHomeTitleButton.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/16.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit

class HQLHomeTitleButton: UIButton {

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置frame
        titleLabel?.frame.origin.x = 0
        
        // 图片的x在label后面
        imageView?.frame.origin.x = titleLabel!.frame.size.width + 3
    }
}
