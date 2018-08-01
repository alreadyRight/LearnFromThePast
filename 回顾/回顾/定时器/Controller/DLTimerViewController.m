//
//  DLTimerViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLTimerViewController.h"
#import "DLTimerFlowLayout.h"
#import "DLTimerCollectionViewCell.h"

NSString * const timerCell = @"timerCell";

@interface DLTimerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSArray * dataList;

@property (nonatomic, weak)UICollectionView * collectionView;

@property (nonatomic, strong)NSTimer * timer;

@property (nonatomic, assign)NSInteger page;

@end

@implementation DLTimerViewController


#pragma mark LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"定时器";
    [self setupCircleView];
    [self startTimeInterval];
}

- (void)startTimeInterval{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(startRun) userInfo:nil repeats:YES];
}

- (void)startRun{
    if (self.page == self.dataList.count) {
        self.page = 0;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.page inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.page++ inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)dealloc{
    [self.timer invalidate];
}

#pragma mark UI
- (void)setupCircleView{
    DLTimerFlowLayout *fl = [[DLTimerFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 256, 40) collectionViewLayout:fl];
    collectionView.backgroundColor = UIColor.yellowColor;
//    collectionView.scrollEnabled = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[DLTimerCollectionViewCell class] forCellWithReuseIdentifier:timerCell];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(@256);
        make.height.mas_equalTo(@40);
    }];
    self.collectionView = collectionView;
}

#pragma mark UICollectionViewDelegate && dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DLTimerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:timerCell forIndexPath:indexPath];
    cell.word = self.dataList[indexPath.row];
    return cell;
}


#pragma mark LazyLoad

- (NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@"第五季开始了",@"单位都爱玩打破胃口多交往",@"我都激动啊山东按揭贷款和窦唯",@"我无爱啊实打实加快进",@"到死刷卡老师的黑娃"];
    }
    return _dataList;
}


@end
