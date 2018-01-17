//
//  DLCustomDoubleViewController.m
//  回顾
//
//  Created by 周冰烽 on 2018/1/17.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLCustomDoubleViewController.h"

@interface DLCustomDoubleViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,weak) UIPickerView *pickerView;

@property(nonatomic,strong)NSArray * dataList;

@property(nonatomic,strong)NSArray * data;

@end

@implementation DLCustomDoubleViewController{
    NSString *_selectID1;
    NSString *_selectName1;
    NSString *_selectID2;
    NSString *_selectName2;
}

#pragma mark - LazyLoad

- (NSArray *)dataList{
    if (!_dataList) {
        //dataList可以自定义,同时可以网络请求把数据填充
        _dataList = @[@{@"ID":@"0",@"name":@"lla",
                        @"data":@[@{@"IDS1":@"0",@"names":@"olw"},@{@"IDS1":@"1",@"names":@"aswsko"},@{@"IDS1":@"2",@"names":@"wsji"},@{@"IDS1":@"3",@"names":@"amksl"}]},
                      @{@"ID":@"1",@"name":@"adwoij",
                        @"data":@[@{@"IDS1":@"0",@"names":@"wilak"},@{@"IDS1":@"1",@"names":@"ajsuwi"},@{@"IDS1":@"2",@"names":@"alsoap"},@{@"IDS1":@"3",@"names":@"aijswj"}]},
                      @{@"ID":@"2",@"name":@"dqjoks",
                        @"data":@[@{@"IDS1":@"0",@"names":@"also"},@{@"IDS1":@"1",@"names":@"wusiao"},@{@"IDS1":@"2",@"names":@"alsopw"},@{@"IDS1":@"3",@"names":@"alskdj"}]}];
    }
    return _dataList;
}

- (NSArray *)data{
    if (!_data) {
        _data = [NSArray array];
        if (_data.count == 0) {
            _data = self.dataList[0][@"data"];
        }
    }
    return _data;
}

#pragma mark - 监听方法

- (void)clickAction{
    if ([_selectID1 isEqualToString:@""] || _selectID1 == nil) {
        _selectID1 = self.dataList[0][@"ID"];
        _selectName1 = self.dataList[0][@"name"];
    }
    if ([_selectID2 isEqualToString:@""] || _selectID2 == nil) {
        _selectID2 = self.data[0][@"IDS1"];
        _selectName2 = self.data[0][@"names"];
    }
    !_chooseValue ?: _chooseValue(_selectID1,_selectName1,_selectID2,_selectName2);
    [super clickAction];
}


#pragma mark - pickerViewDelegate && dataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _selectID1 = self.dataList[row][@"ID"];
        _selectName1 = self.dataList[row][@"name"];
        self.data = self.dataList[row][@"data"];
        [self.pickerView reloadComponent:1];
    }else{
        _selectID2 = self.data[row][@"IDS1"];
        _selectName2 = self.data[row][@"names"];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.dataList.count;
    }else{
        return self.data.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.dataList[row][@"name"];
    }else{
        return self.data[row][@"names"];
    }
}

#pragma mark - UI

- (instancetype)initWithTitle:(NSString *)title{
    self.titleName = title;
    if ([super init]) {
        [self setPickerView];
    }
    return self;
}

- (void)setPickerView{
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.alertView addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.alertView);
        make.height.mas_equalTo(@270);
    }];
    self.pickerView = pickerView;
}

@end
