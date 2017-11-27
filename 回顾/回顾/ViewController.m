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
#import "DLIOS9MainViewController.h"
static NSString * const cellID = @"cellID";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController{
    NSArray *_titArray;
}

- (void)setNormalData{
    _titArray = @[@"仿淘宝详情页",@"collectionView联动",@"定时器循环播放",@"顶部悬浮",@"iOS9锁屏界面"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main";
    [self setNormalData];
    [self setTableView];
}

- (void)setTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = _titArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            {
                //仿淘宝详情页
                DLTBImitationViewController *tbiVC = [[DLTBImitationViewController alloc]init];
                [self.navigationController pushViewController:tbiVC animated:YES];
                break;
            }
        case 1:
        {
            //collectionView联动
            DLCollectionLinkageViewController *clVC = [[DLCollectionLinkageViewController alloc]init];
            [self.navigationController pushViewController:clVC animated:YES];
            break;
        }
        case 2:
        {
            //定时器循环播放
            DLTimerViewController *timerVC = [[DLTimerViewController alloc]init];
            [self.navigationController pushViewController:timerVC animated:YES];
            break;
        }
        case 3:
        {
            //顶部悬浮
            DLTopSuspensionViewController *tsVC = [[DLTopSuspensionViewController alloc]init];
            [self.navigationController pushViewController:tsVC animated:YES];
            break;
        }
        default:
        {
            //iOS9锁屏界面
            DLIOS9MainViewController *imVC = [[DLIOS9MainViewController alloc]init];
            [self.navigationController pushViewController:imVC animated:YES];
            break;
        }
    }
}

@end
