//
//  DLImageViewerFlowLayout.m
//  回顾
//
//  Created by 周冰烽 on 2019/1/17.
//  Copyright © 2019 devil. All rights reserved.
//

#import "DLImageViewerFlowLayout.h"

@implementation DLImageViewerFlowLayout

- (void)prepareLayout{
	[super prepareLayout];
	self.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
	self.collectionView.pagingEnabled = YES;
	self.minimumLineSpacing = 0;
	self.minimumInteritemSpacing = 0;
	self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
