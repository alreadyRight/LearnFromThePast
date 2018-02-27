//
//  DLCardFlowLayout.m
//  回顾
//
//  Created by 周冰烽 on 2018/2/27.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLCardFlowLayout.h"
#define  Width 80
#define  Height 80
@implementation DLCardFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    //设置item的大小
    self.itemSize = CGSizeMake(Width, Height);
    self.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, kScreenWidth/2-Width/2, 0, kScreenWidth/2-Width/2);
    self.minimumLineSpacing = 20;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *arr = [self copyAttributes: [super layoutAttributesForElementsInRect:rect]];
    //屏幕中间线
    CGFloat centerX = self.collectionView.contentOffset.x  + self.collectionView.bounds.size.width /2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attribute in arr) {
        CGFloat distance = fabs(attribute.center.x - centerX);
        //移动的距离和屏幕宽的比例
        CGFloat screenScale = distance / kScreenWidth;
        //卡片移动到固定范围内 -π 到 π
        CGFloat scale = fabs(cos(screenScale * M_PI * 3.0 / 4.0));
        //设置cell的缩放 按照余弦函数曲线  越居中越接近于1
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
        //透明度
        attribute.alpha = scale;
    }
    return arr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
-(NSArray *)copyAttributes:(NSArray  *)arr{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in arr) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

@end
