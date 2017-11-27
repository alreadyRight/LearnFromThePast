//
//  DLCollectionLinkageViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLCollectionLinkageViewController.h"
#import "DLTopFlowLayout.h"
#import "DLTopCollectionViewCell.h"
#import "DLDataFlowLayout.h"
#import "DLDataCollectionViewCell.h"
#define kTopViewHeight 40
static NSString * const topCell = @"topCell";
static NSString * const dataCell = @"dataCell";
@interface DLCollectionLinkageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak) UICollectionView * topCollectionView;

@property(nonatomic,weak) UICollectionView * dataCollectionView;

@property(nonatomic,weak) UIView * tipLine;

@end

@implementation DLCollectionLinkageViewController{
    NSMutableArray *_topArray;
    NSInteger currentItem;
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
    [self setTopCollection];
    [self setDataCollection];
}

- (void)setTopCollection{
    UIView *tipLine = [[UIView alloc]initWithFrame:CGRectMake(2, kNavigationHeight + 40, (kScreenWidth / 5.0 - 4), 42)];
    tipLine.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:tipLine];
    self.tipLine = tipLine;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kTopViewHeight) collectionViewLayout:[[DLTopFlowLayout alloc]init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[DLTopCollectionViewCell class] forCellWithReuseIdentifier:topCell];
    [self.view addSubview:collectionView];
    self.topCollectionView = collectionView;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-8);
        make.top.equalTo(self.view).offset(41 + kNavigationHeight);
        make.height.mas_equalTo(@0.3);
    }];
}

- (void)setDataCollection{
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavigationHeight + kTopViewHeight + 2, kScreenWidth, kScreenHeight - kNavigationHeight - kTopViewHeight - 2) collectionViewLayout:[[DLDataFlowLayout alloc]init]];
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
    if (collectionView == self.topCollectionView) {
        DLTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCell forIndexPath:indexPath];
        cell.text = _topArray[indexPath.item];
        return cell;
    }else{
        DLDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dataCell forIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.dataCollectionView) {
        CGFloat xOffset = scrollView.contentOffset.x / self.dataCollectionView.frame.size.width;
        [UIView animateWithDuration:0.1 animations:^{
            [self.topCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:xOffset inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                [self.topCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:xOffset inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionRight];
            }];
        }];
    }
    
}

@end
