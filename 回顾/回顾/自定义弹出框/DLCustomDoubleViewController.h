//
//  DLCustomDoubleViewController.h
//  回顾
//
//  Created by 周冰烽 on 2018/1/17.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLBaseAlertViewController.h"

@interface DLCustomDoubleViewController : DLBaseAlertViewController

- (instancetype)initWithTitle:(NSString *)title;

@property(nonatomic,copy) void(^chooseValue)(NSString *ID1,NSString *name1,NSString *ID2,NSString *name2);

@end
