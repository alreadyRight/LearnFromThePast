//
//  DLAlignmentFlowLayout.h
//  回顾
//
//  Created by 周冰烽 on 2018/5/30.
//  Copyright © 2018年 devil. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AlignType){
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};

@interface DLAlignmentFlowLayout : UICollectionViewFlowLayout

//cell对齐方式
@property (nonatomic,assign)AlignType cellType;

@end
