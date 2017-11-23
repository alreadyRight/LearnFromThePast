//
//  ViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "ViewController.h"
#import "DLTBImitationViewController.h"
#import "DLCollectionLinkageViewController.h"
#import "DLTimerViewController.h"
#import "DLTopSuspensionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main";
}

- (IBAction)TBDetailPush:(id)sender {
    DLTBImitationViewController *tbiVC = [[DLTBImitationViewController alloc]init];
    [self.navigationController pushViewController:tbiVC animated:YES];
}
- (IBAction)collectionLinkage:(id)sender {
    DLCollectionLinkageViewController *clVC = [[DLCollectionLinkageViewController alloc]init];
    [self.navigationController pushViewController:clVC animated:YES];
}
- (IBAction)timer:(id)sender {
    DLTimerViewController *timerVC = [[DLTimerViewController alloc]init];
    [self.navigationController pushViewController:timerVC animated:YES];
}
- (IBAction)topSuspension:(id)sender {
    DLTopSuspensionViewController *tsVC = [[DLTopSuspensionViewController alloc]init];
    [self.navigationController pushViewController:tsVC animated:YES];
}

@end
