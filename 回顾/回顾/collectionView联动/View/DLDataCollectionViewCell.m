//
//  DLDataCollectionViewCell.m
//  回顾
//
//  Created by bxkj on 2017/11/24.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLDataCollectionViewCell.h"

@implementation DLDataCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor DLRandomColor];
}




@end
