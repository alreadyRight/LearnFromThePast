//
//  DLTBImitationViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLTBImitationViewController.h"

#define kTopViewHeight 40

#define kBottomHeight 50

static NSString * const cellID = @"cellID";

@interface DLTBImitationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UIView * tipLine;

@property(nonatomic,weak) UITableView * tableView;

@end

@implementation DLTBImitationViewController{
    UIButton *_productBtn;
    UIButton *_detailBtn;
    UIButton *_msgBtn;
    UIButton *_pushBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"仿淘宝详情页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopView];
    [self setTableView];
    [self setBottomView];
}
- (void)setTopView{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationHeight);
        make.height.mas_equalTo(@(kTopViewHeight));
    }];
    [self setButtonsWithIndex:0 title:@"宝贝" superView:topView];
    [self setButtonsWithIndex:1 title:@"详情" superView:topView];
    [self setButtonsWithIndex:2 title:@"评价" superView:topView];
    [self setButtonsWithIndex:3 title:@"推荐" superView:topView];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(@0.5);
    }];
    
    UIView *tipLine = [[UIView alloc]init];
    tipLine.backgroundColor = [UIColor orangeColor];
    tipLine.frame = CGRectMake(5, 37, kScreenWidth / 4.0 - 10, 2);
    [topView addSubview:tipLine];
    self.tipLine = tipLine;
}

- (void)setBottomView{
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@(kBottomHeight));
    }];
    [self setBottomLeftButtonWithIndex:0 title:@"商铺" superView:bottomView];
    [self setBottomLeftButtonWithIndex:1 title:@"客服" superView:bottomView];
    [self setBottomLeftButtonWithIndex:2 title:@"收藏" superView:bottomView];
    
    [self setBottomRightButtonWithIndex:0 title:@"加入购物车" color:[UIColor colorWithRed:253/255.0 green:179/255.0 blue:43/255.0 alpha:1.0] superView:bottomView];
    [self setBottomRightButtonWithIndex:1 title:@"立即购买" color:[UIColor colorWithRed:252/255.0 green:96/255.0 blue:32/255.0 alpha:1.0] superView:bottomView];
}

- (void)setBottomLeftButtonWithIndex:(NSInteger)index title:(NSString *)title superView:(UIView *)superView{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    btn.tag = index;
    [superView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(superView);
        make.left.equalTo(superView).offset(index * ((kScreenWidth / 2.0 - 40) / 3.0));
        make.width.mas_equalTo(@((kScreenWidth / 2.0 - 40) / 3.0));
    }];
}

- (void)setBottomRightButtonWithIndex:(NSInteger)index title:(NSString *)title color:(UIColor *)color superView:(UIView *)superView{
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundColor:color];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    btn.tag = index;
    [superView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset((kScreenWidth / 2.0) + (index * (kScreenWidth / 2.0 + 40) / 2.0) - 40);
        make.bottom.top.equalTo(superView);
        make.width.mas_equalTo(@((kScreenWidth / 2.0 + 40) / 2.0));
    }];
}

- (void)setButtonsWithIndex:(NSInteger)index title:(NSString *)title superView:(UIView *)superView{
    UIButton *btn = [[UIButton alloc]init];
    
    //默认样式
    NSMutableAttributedString *normalAttr = [[NSMutableAttributedString alloc] initWithString:title];
    NSDictionary *normalAttrDict = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                           NSForegroundColorAttributeName :[UIColor grayColor]
                           };
    [normalAttr addAttributes:normalAttrDict range:NSMakeRange(0, title.length)];
    [btn setAttributedTitle:normalAttr forState:UIControlStateNormal];
    
    //选中样式
    NSMutableAttributedString *selectAttr = [[NSMutableAttributedString alloc] initWithString:title];
    NSDictionary *selectAttrDict = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                                     NSForegroundColorAttributeName:[UIColor orangeColor]
                                     };
    [selectAttr addAttributes:selectAttrDict range:NSMakeRange(0, title.length)];
    [btn setAttributedTitle:selectAttr forState:UIControlStateSelected];
    
    btn.tag = index;
    
    [btn addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
    
    [superView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(index * (kScreenWidth / 4.0));
        make.top.bottom.equalTo(superView);
        make.width.mas_equalTo(@(kScreenWidth / 4.0));
    }];
    if (btn.tag == 0) {
        [self clickTitle:btn];
    }
    switch (btn.tag) {
        case 0:
            _productBtn = btn;
            break;
        case 1:
            _detailBtn = btn;
            break;
        case 2:
            _msgBtn = btn;
            break;
        default:
            _pushBtn = btn;
            break;
    }
}

- (void)clickTitle:(UIButton *)sender{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)setTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight + kTopViewHeight, kScreenWidth, kScreenHeight - kNavigationHeight - kTopViewHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 44;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc]init];
    NSDictionary *attrDict = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:12.0f],
                               NSForegroundColorAttributeName:[UIColor blackColor]
                               };
    NSMutableAttributedString *attr1 = [[NSMutableAttributedString alloc]initWithString:@"------宝贝------" attributes:attrDict];
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc]initWithString:@"------详情------" attributes:attrDict];
    NSMutableAttributedString *attr3 = [[NSMutableAttributedString alloc]initWithString:@"------评价------" attributes:attrDict];
    NSMutableAttributedString *attr4 = [[NSMutableAttributedString alloc]initWithString:@"------推荐------" attributes:attrDict];
    switch (section) {
        case 0:
            label.attributedText = attr1;
            break;
        case 1:
            label.attributedText = attr2;
            break;
        case 2:
            label.attributedText = attr3;
            break;
        default:
            label.attributedText = attr4;
            break;
    }
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerView);
    }];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"商品%zd",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSIndexPath *indexPath = [[self.tableView indexPathsForVisibleRows] firstObject];
    [UIView animateWithDuration:0.4 animations:^{
        self.tipLine.frame = CGRectMake(5 + (indexPath.section * (kScreenWidth / 4.0)), 37, kScreenWidth / 4.0 - 10, 2);
    }];
    switch (indexPath.section) {
        case 0:
            _productBtn.selected = YES;
            _detailBtn.selected = NO;
            _msgBtn.selected = NO;
            _pushBtn.selected = NO;
            break;
        case 1:
            _productBtn.selected = NO;
            _detailBtn.selected = YES;
            _msgBtn.selected = NO;
            _pushBtn.selected = NO;
            break;
        case 2:
            _productBtn.selected = NO;
            _detailBtn.selected = NO;
            _msgBtn.selected = YES;
            _pushBtn.selected = NO;
            break;
        default:
            _productBtn.selected = NO;
            _detailBtn.selected = NO;
            _msgBtn.selected = NO;
            _pushBtn.selected = YES;
            break;
    }
}






@end
