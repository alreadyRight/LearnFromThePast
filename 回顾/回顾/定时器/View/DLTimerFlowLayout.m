//
//  DLTimerFlowLayout.m
//  回顾
//
//  Created by 周冰烽 on 2018/6/1.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLTimerFlowLayout.h"

@implementation DLTimerFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = CGSizeMake(256, 40);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

@end
