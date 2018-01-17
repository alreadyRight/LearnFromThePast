//
//  DLBaseAlertViewController.h
//  回顾
//
//  Created by 周冰烽 on 2018/1/17.
//  Copyright © 2018年 devil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLBaseAlertViewController : UIViewController

//- (void)setupUI;
/** 点击确定按钮 */
- (void)clickAction;
/** 弹出视图,自定义视图时,此为父View,将其他subView添加到这个View上 */
@property(nonatomic,weak)UIView * alertView;
/** 弹出框标题 */
@property(nonatomic,copy)NSString * titleName;

@end
