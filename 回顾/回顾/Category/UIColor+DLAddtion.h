//
//  UIColor+DLAddtion.h
//  回顾
//
//  Created by 周冰烽 on 2017/11/28.
//  Copyright © 2017年 devil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DLAddtion)

+ (instancetype)DLColorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(CGFloat)alpha;

+ (instancetype)DLColorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

+(instancetype)DLRandomColor;

@end
