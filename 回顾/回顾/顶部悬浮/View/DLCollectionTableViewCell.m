//
//  DLCollectionTableViewCell.m
//  回顾
//
//  Created by 周冰烽 on 2018/8/2.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLCollectionTableViewCell.h"
static NSString * cellID = @"cellID";
@interface DLCollectionTableViewCell()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DLCollectionTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 0;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"啦啦啦啦啦%zd个",indexPath.row];
    
    return cell;
}

@end
