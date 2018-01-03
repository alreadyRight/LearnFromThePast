//
//  DLMapSearchViewController.m
//  回顾
//
//  Created by 周冰烽 on 2018/1/3.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLMapSearchViewController.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import "UIScrollView+Refresh.h"
static NSString * const cellID = @"cellID";
@interface DLMapSearchViewController ()<UITextFieldDelegate,BMKPoiSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation DLMapSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
