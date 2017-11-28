//
//  DLCollectionLinkageViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLCollectionLinkageViewController.h"
#import "DLLinkageView.h"
@interface DLCollectionLinkageViewController ()

@end

@implementation DLCollectionLinkageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联动";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI{
    NSArray *array = @[@"欢呼声",@"孔老二O__O ",@"俺姥我可",@"am科鲁兹",@"咯阿婆说",@"阿婆无聊",@"群殴我看动漫",@"强迫孔卡破洞裤",@"老师看到你",@"派克物联网",@"安排咯",@"Akira",@"欧乐堡",@"安排老师",@"缺乏",@"懒",@"形成",@"强迫了我们"];
    DLLinkageView *linkageView = [[DLLinkageView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight) dataList:array];
    [self.view addSubview:linkageView];
}

@end
