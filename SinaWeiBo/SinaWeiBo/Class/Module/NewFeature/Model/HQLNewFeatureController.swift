//
//  HQLNewFeatureController.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/15.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewFeatureCell"
// 定义cell的个数
private let itemCount = 4

class HQLNewFeatureController: UICollectionViewController{
    // MARK: - 属性
    /// layout
    private let layout = UICollectionViewFlowLayout()
    
    // ==================MARK: - 生命周期方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置collectionView
        prepareCollectionView()
    }
    
    // ==================MARK: - 私有方法
    private func prepareCollectionView(){
        // 注册cell
        self.collectionView?.registerClass(HQLNewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // 设置layout
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
    }
}
// MARK: - 代理方法
extension HQLNewFeatureController{
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 直接取cell
        // dequeueReusableCellWithReuseIdentifier: 取cell会先去缓存池中取cell,缓存池中取不到会使用注册的cell来创建
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HQLNewFeatureCell
        
        cell.index = indexPath.item
            
        // 设置cell
        cell.backgroundColor = GlobalBKColor
        
        return cell
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // 计算index
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
        if index == itemCount - 1{
            // 判读是否为最后一页
            let indexPath = NSIndexPath(forItem: index, inSection: 0)
            let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! HQLNewFeatureCell
            cell.startAnimation()
        }
    }
}

