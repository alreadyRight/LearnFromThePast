//
//  DLTopCollectionViewCell.h
//  回顾
//
//  Created by bxkj on 2017/11/23.
//  Copyright © 2017年 devil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLTopCollectionViewCell : UICollectionViewCell

@property(nonatomic,copy) NSString * text;

@property(nonatomic,copy) void(^clickBtn)(UIButton *sender);

@end
