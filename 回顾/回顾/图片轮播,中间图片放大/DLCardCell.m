//
//  DLCardCell.m
//  回顾
//
//  Created by 周冰烽 on 2018/2/27.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLCardCell.h"

@implementation DLCardCell{
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
    }];
    _imageView = imageView;
}

- (void)setImageName:(NSString *)imageName{
    _imageView.image = [UIImage imageNamed:imageName];
}



@end
