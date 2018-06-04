//
//  DLTimerCollectionViewCell.m
//  回顾
//
//  Created by 周冰烽 on 2018/6/1.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLTimerCollectionViewCell.h"

@implementation DLTimerCollectionViewCell{
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UILabel *label = [[UILabel alloc]init];
    label.text = @"我是跑马灯";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
    }];
    _label = label;
}

- (void)setWord:(NSString *)word{
    _label.text = word;
}

@end
