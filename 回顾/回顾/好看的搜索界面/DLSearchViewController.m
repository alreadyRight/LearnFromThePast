//
//  DLSearchViewController.m
//  回顾
//
//  Created by 周冰烽 on 2018/5/29.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLSearchViewController.h"
#import "DLSearchTableViewCell.h"
NSString * const searchTableViewCell = @"searchTableViewCell";
@interface DLSearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UITextField * searchView;

@property(nonatomic,weak) UITableView * tableView;

@property(nonatomic,weak) UIView * tipLine;

@property(nonatomic,weak) UIButton * currentBtn;

@property(nonatomic,strong)NSArray * hotSearchArray;

@property(nonatomic,strong)NSArray * hisSearchArray;

@end

@implementation DLSearchViewController{
    NSInteger _status;
}


#pragma mark - lickEvent

- (void)clickCate:(UIButton *)sender{
    self.currentBtn.selected = NO;
    sender.selected = YES;
    self.currentBtn = sender;
    _status = sender.tag;
    [UIView animateWithDuration:0.3 animations:^{
        self.tipLine.frame = CGRectMake(5 + sender.tag * (kScreenWidth / 3.0), 37, (kScreenWidth / 3.0) - 10, 1.5);
    }];
}

- (void)cancelBtnClick{
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - LifeCircle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.searchView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setUpsearch];
    [self setCateBtn];
    [self setMainTableView];
}

- (void)setUpsearch{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationHeight)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor DLColorWithRed:242 green:242 blue:242 alpha:1.0];
    bgView.layer.cornerRadius = 4.0f;
    [navView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navView.mas_left).offset(16);
        if (iPhoneX) {
            make.top.equalTo(navView.mas_top).offset(47);
        }else {
            make.top.equalTo(navView.mas_top).offset(23);
        }
        make.bottom.equalTo(navView.mas_bottom).offset(-7);
        make.width.offset(kScreenWidth * 0.8);
    }];
    UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rectangle 2seek"]];
    [bgView addSubview:searchImage];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.width.offset(16);
        make.centerY.equalTo(bgView.mas_centerY).offset(0);
    }];
    UITextField *search = [[UITextField alloc] init];
    self.searchView = search;
    if (self.searchText != nil) {
        self.searchView.text = self.searchText;
    }
    search.returnKeyType = UIReturnKeySearch;//更改键盘的return
    search.delegate = self;
    search.placeholder = @"请输入搜索内容";
    search.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImage.mas_right).offset(10);
        make.top.equalTo(bgView.mas_top).offset(5);
        make.bottom.equalTo(bgView.mas_bottom).offset(-5);
        make.right.equalTo(bgView.mas_right).offset(-5);
    }];
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [navView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY).offset(0);
        make.left.equalTo(bgView.mas_right).offset(15);
        make.width.offset(30);
    }];
}

- (void)setCateBtn{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationHeight);
        make.height.mas_equalTo(@40);
    }];
    [self setButtonWithIndex:0 title:@"移动开发" view:view];
    [self setButtonWithIndex:1 title:@"后台开发" view:view];
    [self setButtonWithIndex:2 title:@"前端开发" view:view];
    
    UIView *tipLine = [[UIView alloc]initWithFrame:CGRectMake(5, 37, (kScreenWidth / 3.0) - 10, 1.5)];
    tipLine.backgroundColor = [UIColor DLColorWithHex:0xFC9227 alpha:1.0];
    [view addSubview:tipLine];
    self.tipLine = tipLine;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor DLColorWithHex:0xF6F7F9 alpha:1.0];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(@1);
    }];
}

- (void)setButtonWithIndex:(NSInteger)index title:(NSString *)title view:(UIView *)view{
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = index;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor DLColorWithHex:0x6F6F6F alpha:1.0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor DLColorWithHex:0xFC9227 alpha:1.0] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn addTarget:self action:@selector(clickCate:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(index * (kScreenWidth / 3.0));
        make.top.bottom.equalTo(view);
        make.width.mas_equalTo(@(kScreenWidth / 3.0));
    }];
    if (btn.tag == 0) {
        [self clickCate:btn];
    }
}

- (void)setMainTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight + 40, kScreenWidth, kScreenHeight - kNavigationHeight - 40) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 44;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    [tableView registerClass:[DLSearchTableViewCell class] forCellReuseIdentifier:searchTableViewCell];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}



#pragma mark - UITableViewDelegate && dataSource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    label.textColor = [UIColor DLColorWithRed:111 green:111 blue:111 alpha:1.0];
    if (section == 0) {
        label.text = @"热门推荐";
    }else{
        label.text = @"历史搜索";
    }
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(18);
        make.centerY.equalTo(view);
    }];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"清除历史记录";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor DLColorWithRed:163 green:163 blue:163 alpha:1.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }else{
        DLSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchTableViewCell forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.dataList = self.hotSearchArray;
        }else{
            cell.dataList = self.hisSearchArray;
        }
        return cell;
    }
}



#pragma mark - LazyLoad

- (NSArray *)hotSearchArray{
    if (!_hotSearchArray) {
        _hotSearchArray = @[@"Ruby",@"JavaScript",@"Java",@"Go",@"Python",@"Objective-C",@"Swift",@"C++",@"C#",@"HTML",@"CSS",@"React-Native",@"Perl"];
    }
    return _hotSearchArray;
}

- (NSArray *)hisSearchArray{
    if (!_hisSearchArray) {
        _hisSearchArray =  @[@"香菇青菜",@"油炸小黄鱼",@"麻婆豆腐",@"红烧鲫鱼",@"糖醋排骨",@"酸辣土豆丝",@"毛豆肉丝",@"蚂蚁上树",@"酸菜鱼",@"干菜蒸肉",@"红烧肉",@"酱爆螺丝",@"宫保鸡丁"];
    }
    return _hisSearchArray;
}


@end
