//
//  DLCustomSingleAlertViewController.h
//  回顾
//
//  Created by 周冰烽 on 2018/1/17.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLBaseAlertViewController.h"

@interface DLCustomSingleAlertViewController : DLBaseAlertViewController

- (instancetype)initWithTitle:(NSString *)title dataList:(NSArray *)dataList originID:(NSString *)originID;

@property(nonatomic,copy) void(^chooseValue)(NSString *ID,NSString *name);

@end
