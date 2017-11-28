//
//  DLLinkageView.m
//  回顾
//
//  Created by 周冰烽 on 2017/11/28.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLLinkageView.h"
#import "BXChannelLabel.h"
#import "DLDataFlowLayout.h"
#import "DLDataCollectionViewCell.h"

#define labelW 80
#define labelH 40
#define lineW 80
#define lineH 2

static NSString * const dataCell = @"dataCell";

@interface DLLinkageView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak) UICollectionView *collectionView;

@property(nonatomic,weak) UIScrollView *topScrollView;

@property(nonatomic,weak) UIView *lineView;

@end

@implementation DLLinkageView{
    NSArray *_dataList;
    NSMutableArray *_labelArray;
}

- (void)setNormal{
    if (_dataList == nil) {
        _dataList = [NSArray array];
    }
    if (_labelArray == nil) {
        _labelArray = [NSMutableArray array];
    }
}

- (instancetype)initWithFrame:(CGRect)frame dataList:(NSArray *)dataList{
    _dataList = dataList;
    if (self = [super initWithFrame:frame]) {
        [self setNormal];
        [self setUI];
        [self setDataCollection];
    }
    return self;
}

- (void)setUI{
    UIScrollView *topScrollView  = [[UIScrollView alloc] init];
    self.topScrollView = topScrollView;
    topScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:topScrollView];
    [topScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
        make.height.offset(40);
    }];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, labelH- kScreenScale, labelW * _dataList.count, kScreenScale)];
    line.backgroundColor = [UIColor lightGrayColor];
    [topScrollView addSubview:line];
    for (NSInteger i = 0; i < _dataList.count; i++) {
        BXChannelLabel *label = [[BXChannelLabel alloc] init];
        [topScrollView addSubview:label];
        CGFloat labelX = labelW * i;
        label.frame = CGRectMake(labelX, 0, labelW, labelH);
        label.text = _dataList[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapClick:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        label.tag = i;
        [_labelArray addObject:label];
        if (i == 0) {
            label.scale = 1.0;
            CGFloat centerX = labelW * i + labelW * 0.5;
            //创建那个线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(centerX - lineW *0.5, labelH - lineH, lineW, lineW)];
            self.lineView = lineView;
            lineView.backgroundColor = [UIColor orangeColor];
            [topScrollView addSubview:lineView];
        }
    }
    topScrollView.contentSize = CGSizeMake(labelW * _dataList.count, 0);
}

- (void)labelTapClick:(UITapGestureRecognizer *)tap {
    BXChannelLabel *tapLabel = (BXChannelLabel *)tap.view;
    CGFloat offSetX = tapLabel.center.x - self.bounds.size.width * 0.5;
    CGFloat minOffSetX = 0;
    CGFloat maxOffSetX = self.topScrollView.contentSize.width - self.bounds.size.width;
    if (offSetX < minOffSetX) {
        offSetX = minOffSetX;
    }
    if (offSetX > maxOffSetX) {
        offSetX = maxOffSetX;
    }
    CGPoint point = CGPointMake(offSetX, 0);
    [self.topScrollView setContentOffset:point animated:YES];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:tapLabel.tag inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    for (int i = 0; i < _labelArray.count; i++) {
        BXChannelLabel *label = _labelArray[i];
        if (i == tapLabel.tag) {
            label.scale = 1.0;
            [UIView animateWithDuration:0.1 animations:^{
                CGFloat centerX = labelW * i + labelW * 0.5;
                self.lineView.x = centerX -lineW *0.5;
            }];
        } else {
            label.scale = 0.0;
        }
    }
}

- (void)setDataCollection{
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, labelH, kScreenWidth, kScreenHeight - labelH) collectionViewLayout:[[DLDataFlowLayout alloc]init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[DLDataCollectionViewCell class] forCellWithReuseIdentifier:dataCell];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DLDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dataCell forIndexPath:indexPath];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.bounds.size.width;
    BXChannelLabel *label = _labelArray[index];
    CGFloat offSetX = label.center.x - self.bounds.size.width * 0.5;
    CGFloat minOffSetX = 0;
    CGFloat maxOffSetX = self.topScrollView.contentSize.width - self.bounds.size.width;
    if (offSetX < minOffSetX) {
        offSetX = minOffSetX;
    }
    if (offSetX > maxOffSetX) {
        offSetX = maxOffSetX;
    }
    CGPoint point = CGPointMake(offSetX, 0);
    [self.topScrollView setContentOffset:point animated:YES];
    [UIView animateWithDuration:0.1 animations:^{
        CGFloat centerX = labelW * index + labelW * 0.5;
        self.lineView.x = centerX -lineW *0.5;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.bounds.size.width;
    CGFloat index_float = scrollView.contentOffset.x / self.bounds.size.width;
    CGFloat rightScale = index_float - index;
    CGFloat leftSccale = 1 - rightScale;
    NSInteger leftIndex = index;
    NSInteger rightIndex = leftIndex + 1;
    BXChannelLabel *leftLabel = _labelArray[leftIndex];
    leftLabel.scale = leftSccale;
    if (rightIndex < _labelArray.count) {
        BXChannelLabel *rightLabel = _labelArray[rightIndex];
        rightLabel.scale = rightScale;
    }
    [UIView animateWithDuration:0.1 animations:^{
        CGFloat centerX = labelW * index_float + labelW * 0.5;
        self.lineView.x = centerX -lineW *0.5;
    }];
}


@end
