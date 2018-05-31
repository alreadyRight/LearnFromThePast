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
#import "DLBaiduMapViewController.h"
#import "DLCustomSingleAlertViewController.h"
#import "DLCustomDoubleViewController.h"
#import "DLPicLoopViewController.h"
#import "DLSearchViewController.h"
static NSString * const cellID = @"cellID";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController{
    NSArray *_titArray;
}

- (void)setNormalData{
    _titArray = @[@"仿淘宝详情页",@"collectionView联动",@"定时器循环播放",@"顶部悬浮",@"iOS9锁屏界面",@"好看的搜索界面",@"关于百度地图的一些事情",@"自定义弹出框",@"自定义弹出框双层夹心",@"图片轮播,中间图片放大",@"还在构思下一个~~"];
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
        case 4:
        {
            //iOS9锁屏界面
            DLIOS9MainViewController *imVC = [[DLIOS9MainViewController alloc]init];
            [self.navigationController pushViewController:imVC animated:YES];
            break;
        }
        case 5:
        {
            //好看的搜索界面
            DLSearchViewController *searchVC = [[DLSearchViewController alloc]init];
            [self.navigationController pushViewController:searchVC animated:NO];
            break;
        }
        case 6:
        {
            //关于百度地图的一些事情
            DLBaiduMapViewController *mapVC = [[DLBaiduMapViewController alloc]init];
            [self.navigationController pushViewController:mapVC animated:YES];
            break;
        }
        case 7:
        {
            //自定义弹出框,可以更改文件,将弹出视图自定义
            NSArray *array = @[@{@"ID":@"1",@"name":@"张三"},@{@"ID":@"2",@"name":@"李四"},@{@"ID":@"3",@"name":@"王五"},@{@"ID":@"4",@"name":@"赵六"},@{@"ID":@"5",@"name":@"憋七"},@{@"ID":@"6",@"name":@"大巴"}];
            DLCustomSingleAlertViewController *alert = [[DLCustomSingleAlertViewController alloc]initWithTitle:@"选择名字" dataList:array originID:@"4"];
            [self presentViewController:alert animated:NO completion:nil];
            alert.chooseValue = ^(NSString *ID, NSString *name) {
                DLog(@"%@,%@",ID,name);
            };
            break;
        }
        case 8:
        {
            DLCustomDoubleViewController *alert = [[DLCustomDoubleViewController alloc]initWithTitle:@"选择一下"];
            [self presentViewController:alert animated:NO completion:nil];
            alert.chooseValue = ^(NSString *ID1, NSString *name1, NSString *ID2, NSString *name2) {
                DLog(@"%@,%@,%@,%@",ID1,name1,ID2,name2);
            };
            break;
        }
        case 9:
        {
            DLPicLoopViewController *picLoopVC = [[DLPicLoopViewController alloc]init];
            [self.navigationController pushViewController:picLoopVC animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
