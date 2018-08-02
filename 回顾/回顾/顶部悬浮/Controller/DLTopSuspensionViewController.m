//
//  DLTopSuspensionViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLTopSuspensionViewController.h"
#import "DLImageHeaderCell.h"
#import "DLCollectionBottomCell.h"
static NSString * bottomCellID = @"bottomCellID";

static NSString * imageHeaderCell = @"imageHeaderCell";

@interface DLTopSuspensionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView * tableView;

@property (nonatomic, weak)UIView * skipLine;

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
    [tableView registerClass:[DLCollectionBottomCell class] forCellReuseIdentifier:bottomCellID];
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
        return kScreenHeight - 250 - 64 - 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        UIView *headerView = [[UIView alloc]init];
        headerView.backgroundColor = [UIColor whiteColor];
        
        for (NSInteger i = 0; i < 4; i++) {
            [self setSubViewWithSuperView:headerView index:i];
        }
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor DLColorWithHex:0xf6f7f9 alpha:1.0];
        [headerView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(headerView);
            make.height.mas_equalTo(1);
        }];
        
        UIView *skipLine = [[UIView alloc]init];
        skipLine.backgroundColor = [UIColor redColor];
        [headerView addSubview:skipLine];
        [skipLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(headerView);
            make.height.mas_equalTo(@1);
            make.width.mas_equalTo(@(kScreenWidth / 4.0));
        }];
        self.skipLine = skipLine;
        
        return headerView;
    }
}

- (void)setSubViewWithSuperView:(UIView *)superView index:(NSInteger)index{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:[NSString stringWithFormat:@"第%zd个",index] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [superView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth / 4.0);
        make.height.mas_equalTo(39);
        make.left.equalTo(superView).offset(index * kScreenWidth / 4.0);
        make.top.equalTo(superView);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DLImageHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:imageHeaderCell forIndexPath:indexPath];
        cell.imageName = @"Bitmap";
        return cell;
    }else{
        DLCollectionBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:bottomCellID forIndexPath:indexPath];
        
        return cell;
    }
}


@end
