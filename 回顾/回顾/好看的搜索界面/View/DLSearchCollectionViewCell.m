//
//  DLSearchCollectionViewCell.m
//  回顾
//
//  Created by 周冰烽 on 2018/5/30.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLSearchCollectionViewCell.h"

@implementation DLSearchCollectionViewCell{
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1/1.0];
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            [make edges];
        }];
        label.text = @"😁😁😁";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        label.numberOfLines = 1;
        label.textColor = [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1/1.0];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(10);
            make.right.equalTo(view).offset(-10);
            make.top.equalTo(view).offset(4);
            make.bottom.equalTo(view).offset(-4);
        }];
        _label = label;
    }
    return self;
}

- (void)setLabelName:(NSString *)labelName{
    _label.text = labelName;
}

@end
