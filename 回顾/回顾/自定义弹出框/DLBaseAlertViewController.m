//
//  DLBaseAlertViewController.m
//  回顾
//
//  Created by 周冰烽 on 2018/1/17.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLBaseAlertViewController.h"

@interface DLBaseAlertViewController ()

@property(nonatomic,weak)UIView * bgView;

@end

@implementation DLBaseAlertViewController


#pragma mark - 监听

- (void)clickCancel{
    [UIView animateWithDuration:0.4 animations:^{
        self.alertView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 300);
        self.bgView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)clickAction{
    [UIView animateWithDuration:0.4 animations:^{
        self.alertView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 300);
        self.bgView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}


#pragma mark - UI

- (instancetype)init{
    if ([super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor clearColor];
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.48;
    self.bgView = bgView;
    [self.view addSubview:bgView];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCancel)];
    [ges setNumberOfTapsRequired:1];
    [bgView addGestureRecognizer:ges];
    [self setBottomView];
}

- (void)setBottomView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 300)];
    //添加一段时间后执行,界面效果实现
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            view.frame = CGRectMake(0, kScreenHeight - 300, kScreenWidth, 300);
        }];
    });
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    self.alertView = view;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-2);
        make.top.equalTo(view).offset(50);
        make.left.equalTo(view).offset(2);
        make.height.mas_equalTo(@0.2);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    label.text = _titleName;
    label.font = [UIFont systemFontOfSize:20.0f];
    [self.alertView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view).offset(15);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.centerY.equalTo(label);
    }];
    UIButton *actionBtn = [[UIButton alloc]init];
    [actionBtn setTitle:@"确定" forState:UIControlStateNormal];
    [actionBtn setTitleColor:[UIColor DLColorWithHex:0xFFFF8605 alpha:1.0] forState:UIControlStateNormal];
    actionBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [actionBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:actionBtn];
    [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-20);
        make.centerY.equalTo(label);
    }];
    
}

@end
