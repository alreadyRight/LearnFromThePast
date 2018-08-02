//
//  DLCollectionBottomCell.m
//  回顾
//
//  Created by 周冰烽 on 2018/8/2.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLCollectionBottomCell.h"
#import "DLCollectionBottomFlowLayout.h"
#import "DLCollectionTableViewCell.h"

static NSString * tableviewCellID = @"tableviewCellID";

@interface DLCollectionBottomCell()<UICollectionViewDelegate,UICollectionViewDataSource>




@end


@implementation DLCollectionBottomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    DLCollectionBottomFlowLayout *fl = [[DLCollectionBottomFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:fl];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[DLCollectionTableViewCell class] forCellWithReuseIdentifier:tableviewCellID];
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DLCollectionTableViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:tableviewCellID forIndexPath:indexPath];
    
    return item;
}

@end
