//
//  DLCollectionBottomFlowLayout.m
//  回顾
//
//  Created by 周冰烽 on 2018/8/2.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLCollectionBottomFlowLayout.h"

@implementation DLCollectionBottomFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = CGSizeMake(kScreenWidth, self.collectionView.height);
    self.collectionView.pagingEnabled = YES;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
