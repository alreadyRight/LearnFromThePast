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

@property (nonatomic, weak) UITextField *search;

@property (nonatomic, weak) UIView *searchView;

@property (strong, nonatomic) UITableView *searchTableView;

@property(nonatomic,strong) BMKPoiSearch *searcher;

@property(nonatomic,strong) NSMutableArray<BMKPoiInfo *> *dataList;

@property(nonatomic,assign) int curPage;

@end

@implementation DLMapSearchViewController

#pragma mark - 上拉刷新
- (void)refresh{
    WK(weakSelf);
    self.curPage ++;
    [self.searchTableView addBackFooterRefresh:^{
        BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
        citySearchOption.pageIndex = weakSelf.curPage;
        citySearchOption.pageCapacity = 15;
        citySearchOption.city= weakSelf.cityName;
        citySearchOption.keyword = weakSelf.search.text;
        //发起城市内POI检索
        BOOL flag = [weakSelf.searcher poiSearchInCity:citySearchOption];
        if(flag) {
            NSLog(@"城市内检索发送成功");
        }else {
            NSLog(@"城市内检索发送失败");
        }
    }];
}

#pragma mark - textFieldDelegate

- (void)textFieldDidChange:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    //请求参数类BMKCitySearchOption
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = _curPage;
    citySearchOption.pageCapacity = 15;
    citySearchOption.city= self.cityName;
    citySearchOption.keyword = textField.text;
    [self.dataList removeAllObjects];
    //发起城市内POI检索
    BOOL flag = [self.searcher poiSearchInCity:citySearchOption];
    if(flag) {
        NSLog(@"城市内检索发送成功");
    }else {
        //城市内检索发送失败"
        [self.dataList removeAllObjects];
        [self.searchTableView reloadData];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{//搜索方法
    if (textField.text.length > 0) {
        [textField resignFirstResponder];
        //请求参数类BMKCitySearchOption
        BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
        citySearchOption.pageIndex = _curPage;
        citySearchOption.pageCapacity = 15;
        citySearchOption.city= self.cityName;
        citySearchOption.keyword = textField.text;
        [self.dataList removeAllObjects];
        //发起城市内POI检索
        BOOL flag = [self.searcher poiSearchInCity:citySearchOption];
        if(flag) {
            NSLog(@"城市内检索发送成功");
        }else {
            [self.dataList removeAllObjects];
            [self.searchTableView reloadData];
        }
    }
    return YES;
}

#pragma mark - PoiSearchDeleage
//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        [self.dataList addObjectsFromArray:poiResultList.poiInfoList];
        [self.searchTableView reloadData];
        if (poiResultList.poiInfoList.count == 10) {
            [self refresh];
        }
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //起始点有歧义
        [self.dataList removeAllObjects];
        [self.searchTableView reloadData];
    }
    else {
        //抱歉，未找到结果
        [self.dataList removeAllObjects];
        [self.searchTableView reloadData];
    }
}

#pragma mark - 监听
- (void)cancelBtnClick{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - UITableViewDelegate && dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataList[indexPath.row].name;
    cell.detailTextLabel.text = self.dataList[indexPath.row].address;
    //    DXLog(@"(%f,%f)",self.dataList[indexPath.row].pt.longitude,self.dataList[indexPath.row].pt.latitude);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !_chooseAddress ?: _chooseAddress(self.dataList[indexPath.row].pt);
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - UI

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    self.navigationController.navigationBar.hidden = YES;
    [self.search becomeFirstResponder];
    _curPage = 0;
}

//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _searcher.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpsearch];
    [self setTableView];
}


- (void)setUpsearch{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationHeight)];
    navView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor DLColorWithRed:242 green:242 blue:242 alpha:1.0];
                                //colorWithRed:242 green:242 blue:242];
    [self.view addSubview:navView];
    [navView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.bottom.right.equalTo(navView).offset(0);
    }];
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
    self.search = search;
    search.returnKeyType = UIReturnKeySearch;//更改键盘的return
    search.delegate = self;
    search.placeholder = @"请输入关键字";
    search.font = [UIFont systemFontOfSize:14];
    [search addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
    [self.view addSubview:self.searchTableView];
    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view).offset(0);
    }];
}

- (void)setTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.searchTableView = tableView;
}

#pragma mark - lazyLoad

- (BMKPoiSearch *)searcher{
    if (!_searcher) {
        _searcher =[[BMKPoiSearch alloc]init];
        _searcher.delegate = self;
    }
    return _searcher;
}

- (NSArray<BMKPoiInfo *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray<BMKPoiInfo *> new];
    }
    return _dataList;
}

@end
