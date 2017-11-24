//
//  DLDataFlowLayout.m
//  回顾
//
//  Created by bxkj on 2017/11/24.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLDataFlowLayout.h"

@implementation DLDataFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - 42);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
