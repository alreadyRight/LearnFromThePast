//
//  DLTopCollectionViewCell.m
//  回顾
//
//  Created by bxkj on 2017/11/23.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLTopCollectionViewCell.h"

@implementation DLTopCollectionViewCell{
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    _label = label;
}

- (void)setText:(NSString *)text{
    _label.text = text;
}

- (void)setSelected:(BOOL)selected{
    selected = !selected;
    if (selected) {
        _label.textColor = [UIColor grayColor];
        _label.font = [UIFont systemFontOfSize:14.0f];
    }else{
        _label.textColor = [UIColor orangeColor];
        _label.font = [UIFont systemFontOfSize:16.0f];
    }
}

@end
