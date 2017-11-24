//
//  DLTopFlowLayout.m
//  回顾
//
//  Created by bxkj on 2017/11/23.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLTopFlowLayout.h"

@implementation DLTopFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = CGSizeMake(kScreenWidth / 5.0, 40);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.collectionView.bounces = NO;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
