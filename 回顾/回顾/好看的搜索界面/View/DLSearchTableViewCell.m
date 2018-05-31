//
//  DLSearchTableViewCell.m
//  回顾
//
//  Created by 周冰烽 on 2018/5/30.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLSearchTableViewCell.h"
#import "DLAlignmentFlowLayout.h"
#import "DLSearchCollectionViewCell.h"
NSString * const searchHotCollectionViewCell = @"searchHotCollectionViewCell";
@interface DLSearchTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)UICollectionView * collectionView;

@end

@implementation DLSearchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
}

- (void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    if (_dataList.count > 0) {
        [self setCollectionView];
    }
}

- (void)setCollectionView{
    DLAlignmentFlowLayout *fl = [[DLAlignmentFlowLayout alloc]init];
    fl.cellType = AlignWithLeft;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) collectionViewLayout:fl];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    [collectionView registerClass:[DLSearchCollectionViewCell class] forCellWithReuseIdentifier:searchHotCollectionViewCell];
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
        if (iPhone5s) {
            if (_dataList.count % 2 == 1) {
                make.height.mas_equalTo(@((_dataList.count / 2 + 1) * 24));
            }else{
                make.height.mas_equalTo(@(_dataList.count / 2 * 24));
            }
        }else{
            if (_dataList.count % 3 == 0) {
                make.height.mas_equalTo(@(_dataList.count / 3 * 24));
            }else{
                make.height.mas_equalTo(@((_dataList.count / 3 + 1) * 24));
            }
        }
    }];
    self.collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DLSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:searchHotCollectionViewCell forIndexPath:indexPath];
    cell.labelName = self.dataList[indexPath.item];
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    !_selectItem ?: _selectItem(self.dataList[indexPath.item]);
//}

@end
