//
//  DLTopSuspensionViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLTopSuspensionViewController.h"
#import "DLImageHeaderCell.h"

static NSString * cellID = @"cellID";

static NSString * imageHeaderCell = @"imageHeaderCell";

@interface DLTopSuspensionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView * tableView;

@end

@implementation DLTopSuspensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"顶部悬浮";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [tableView registerClass:[DLImageHeaderCell class] forCellReuseIdentifier:imageHeaderCell];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 15;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 250;
    }else{
        return 44;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return [NSString stringWithFormat:@"%zd",section];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DLImageHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:imageHeaderCell forIndexPath:indexPath];
        cell.imageName = @"Bitmap";
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"第%zd个",indexPath.row];
        return cell;
    }
}


@end
