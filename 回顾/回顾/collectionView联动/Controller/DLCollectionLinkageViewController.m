//
//  DLCollectionLinkageViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLCollectionLinkageViewController.h"
#import "DLDataFlowLayout.h"
#import "DLDataCollectionViewCell.h"
#import "BXChannelLabel.h"

#define labelW 80
#define labelH 40
#define lineW 80
#define lineH 2

static NSString * const dataCell = @"dataCell";
@interface DLCollectionLinkageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak) UICollectionView * dataCollectionView;

@property(nonatomic,weak) UIView * tipLine;

@property (nonatomic, weak) UIScrollView *channelScrollView;

@property (nonatomic, strong) NSMutableArray *labelM;

@property (nonatomic, weak) UIView *lineView;

@end

@implementation DLCollectionLinkageViewController{
    NSMutableArray *_topArray;
    NSInteger currentItem;
}

- (NSMutableArray *)labelM{
    if (!_labelM) {
        _labelM = [NSMutableArray array];
    }
    return _labelM;
}

- (void)loadNormalData{
    if (_topArray == nil) {
        _topArray = [NSMutableArray array];
    }
    for (NSInteger i = 1 ; i <= 20 ; i++ ) {
        NSString *str = [NSString stringWithFormat:@"第%zd个",i];
        [_topArray addObject:str];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联动";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNormalData];
    [self setUI];
    [self setDataCollection];
}

- (void)setUI{
    UIScrollView *channelScrollView  = [[UIScrollView alloc] init];
    self.channelScrollView = channelScrollView;
    channelScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:channelScrollView];
    [channelScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationHeight);
        make.height.offset(40);
    }];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, labelH- kScreenScale, labelW * _topArray.count, kScreenScale)];
    line.backgroundColor = [UIColor colorWithRed:246/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
    [channelScrollView addSubview:line];
    for (NSInteger i = 0; i < _topArray.count; i++) {
        BXChannelLabel *label = [[BXChannelLabel alloc] init];
        [channelScrollView addSubview:label];
        CGFloat labelX = labelW * i;
        label.frame = CGRectMake(labelX, 0, labelW, labelH);
        label.text = _topArray[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapClick:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        label.tag = i;
        [self.labelM addObject:label];
        if (i == 0) {
            label.scale = 1.0;
            CGFloat centerX = labelW * i + labelW * 0.5;
            //创建那个线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(centerX - lineW *0.5, labelH - lineH, lineW, lineW)];
            self.lineView = lineView;
            lineView.backgroundColor = [UIColor orangeColor];
            [channelScrollView addSubview:lineView];
        }
    }
    channelScrollView.contentSize = CGSizeMake(labelW * _topArray.count, 0);
}

- (void)labelTapClick:(UITapGestureRecognizer *)tap {
    BXChannelLabel *tapLabel = (BXChannelLabel *)tap.view;
    CGFloat offSetX = tapLabel.center.x - self.view.bounds.size.width * 0.5;
    CGFloat minOffSetX = 0;
    CGFloat maxOffSetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    if (offSetX < minOffSetX) {
        offSetX = minOffSetX;
    }
    if (offSetX > maxOffSetX) {
        offSetX = maxOffSetX;
    }
    CGPoint point = CGPointMake(offSetX, 0);
    [self.channelScrollView setContentOffset:point animated:YES];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:tapLabel.tag inSection:0];
    [self.dataCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    for (int i = 0; i < self.labelM.count; i++) {
        BXChannelLabel *label = self.labelM[i];
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
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavigationHeight + labelH, kScreenWidth, kScreenHeight - kNavigationHeight - labelH) collectionViewLayout:[[DLDataFlowLayout alloc]init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[DLDataCollectionViewCell class] forCellWithReuseIdentifier:dataCell];
    [self.view addSubview:collectionView];
    self.dataCollectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _topArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DLDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dataCell forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    
    BXChannelLabel *label = self.labelM[index];
    CGFloat offSetX = label.center.x - self.view.bounds.size.width * 0.5;
    CGFloat minOffSetX = 0;
    CGFloat maxOffSetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    
    if (offSetX < minOffSetX) {
        offSetX = minOffSetX;
    }
    if (offSetX > maxOffSetX) {
        offSetX = maxOffSetX;
    }
    CGPoint point = CGPointMake(offSetX, 0);
    [self.channelScrollView setContentOffset:point animated:YES];
    [UIView animateWithDuration:0.1 animations:^{
        CGFloat centerX = labelW * index + labelW * 0.5;
        self.lineView.x = centerX -lineW *0.5;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    CGFloat index_float = scrollView.contentOffset.x / self.view.bounds.size.width;
    CGFloat rightScale = index_float - index;
    CGFloat leftSccale = 1 - rightScale;
    NSInteger leftIndex = index;
    NSInteger rightIndex = leftIndex + 1;
    BXChannelLabel *leftLabel = self.labelM[leftIndex];
    leftLabel.scale = leftSccale;
    if (rightIndex < self.labelM.count) {
        BXChannelLabel *rightLabel = self.labelM[rightIndex];
        rightLabel.scale = rightScale;
    }
    [UIView animateWithDuration:0.1 animations:^{
        CGFloat centerX = labelW * index_float + labelW * 0.5;
        self.lineView.x = centerX -lineW *0.5;
    }];
}

@end
