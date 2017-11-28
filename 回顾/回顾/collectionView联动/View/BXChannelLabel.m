//
//  ChannelLabel.m
//  网易新闻23
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BXChannelLabel.h"

@implementation BXChannelLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:14.0];
        self.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}
- (void)setScale:(CGFloat)scale {
    _scale = scale;
    CGFloat gscale = scale;
    if (gscale >= 0.53) {
        gscale = 0.53;
    }
    CGFloat bsclae = 0.02 *scale;
    self.textColor = [UIColor colorWithRed:scale green:gscale blue:bsclae alpha:1.0];
    CGFloat minScale = 1.0;
    CGFloat maxScale = 1.2;
    scale = minScale + (maxScale-minScale) * scale;
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

@end
