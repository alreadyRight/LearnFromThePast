//
//  DLTimerViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLTimerViewController.h"

@interface DLTimerViewController ()

@end

@implementation DLTimerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定时器";
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"timg"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"4:52";
    timeLabel.font = [UIFont systemFontOfSize:100.0f weight:UIFontWeightThin];
    
    timeLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(70);
    }];
    
    UILabel *monthLabel = [[UILabel alloc]init];
    monthLabel.text = @"11月24日 星期五";
    monthLabel.font = [UIFont systemFontOfSize:26.0f];
    monthLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:monthLabel];
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(timeLabel.mas_bottom).offset(10);
    }];
    
    UILabel *chinaLabel = [[UILabel alloc]init];
    chinaLabel.text = @"丁酉年十月初七";
    chinaLabel.font = [UIFont systemFontOfSize:16.0f];
    chinaLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:chinaLabel];
    [chinaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(monthLabel.mas_bottom).offset(10);
    }];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, kScreenHeight - 150, kScreenWidth - 40, 100)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, 100)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    gradientLayer.bounds = view.bounds;
    gradientLayer.position = CGPointMake(view.frame.size.width / 2.0,view.frame.size.height / 2.0);
    gradientLayer.startPoint = CGPointMake(0, .5);
    gradientLayer.endPoint = CGPointMake(1, .5);
    gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.locations = @[@0.2, @0.5, @0.8];
    [view.layer addSublayer:gradientLayer];

    label.text = @"滑动来解锁>>";
    gradientLayer.mask = label.layer;

    CABasicAnimation *gradient = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradient.fromValue = @[@0, @0, @0.25];
    gradient.toValue = @[@0.75, @1, @1];
    gradient.duration = 2.5;
    gradient.repeatCount = HUGE;
    [gradientLayer addAnimation:gradient forKey:nil];

}

@end
