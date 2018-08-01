//
//  DLImageHeaderCell.m
//  回顾
//
//  Created by 周冰烽 on 2018/8/1.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLImageHeaderCell.h"

@implementation DLImageHeaderCell{
    UIImageView *_imageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         [self setupUI];
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
