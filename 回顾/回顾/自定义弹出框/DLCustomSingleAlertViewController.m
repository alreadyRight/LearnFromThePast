//
//  DLCustomSingleAlertViewController.m
//  回顾
//
//  Created by 周冰烽 on 2018/1/17.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLCustomSingleAlertViewController.h"

@interface DLCustomSingleAlertViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,weak) UIPickerView *pickerView;

@end

@implementation DLCustomSingleAlertViewController{
    NSString *_selectID;
    NSString *_selectName;
    NSArray *_dataList;
    NSString *_originID;
}

#pragma mark - 监听方法

- (void)clickAction{
    if ([_selectID isEqualToString:@""] || _selectID == nil) {
        _selectID = _dataList[0][@"ID"];
        _selectName = _dataList[0][@"name"];
    }
    !_chooseValue ?: _chooseValue(_selectID,_selectName);
    [super clickAction];
}


#pragma mark - pickerViewDelegate && dataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectID = _dataList[row][@"ID"];
    _selectName = _dataList[row][@"name"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataList.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataList[row][@"name"];
}

#pragma mark - UI

- (instancetype)initWithTitle:(NSString *)title dataList:(NSArray *)dataList originID:(NSString *)originID{
    self.titleName = title;
    if ([super init]) {
        _dataList = dataList;
        _originID = originID;
        [self setPickerView];
    }
    return self;
}

- (void)setPickerView{
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    //将pickerView位置定位到上次选择的那一项
    if (_originID.length > 0) {
        [_dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj[@"ID"] isEqualToString:_originID]) {
                [pickerView selectRow:idx inComponent:0 animated:YES];
                *stop = YES;
            }
        }];
    }
    [self.alertView addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.alertView);
        make.height.mas_equalTo(@270);
    }];
    self.pickerView = pickerView;
}

@end
