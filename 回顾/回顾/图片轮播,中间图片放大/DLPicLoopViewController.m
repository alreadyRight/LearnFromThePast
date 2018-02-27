//
//  DLPicLoopViewController.m
//  回顾
//
//  Created by 周冰烽 on 2018/2/27.
//  Copyright © 2018年 devil. All rights reserved.
//

// 这个控制器包括视图代码是模仿别人写的,源码的作者忘记了,这边我只是记录一下
// 比源代码多的功能:支持点击切换图片

#import "DLPicLoopViewController.h"
#import "DLCardFlowLayout.h"
#import "DLCardCell.h"
NSString * const cardCell = @"cardCell";
@interface DLPicLoopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)UICollectionView * collectionView;

@property(nonatomic,strong)NSArray * dataList;

@end

@implementation DLPicLoopViewController{
    CGFloat _startX;
    CGFloat _endX;
    NSInteger _currentIndex;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"模仿别人代码写的";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setcollectionView];
}

- (void)setcollectionView{
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kScreenHeight / 2.0, kScreenWidth, 80) collectionViewLayout:[[DLCardFlowLayout alloc]init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
    [collectionView registerClass:[DLCardCell class] forCellWithReuseIdentifier:cardCell];
    collectionView.showsHorizontalScrollIndicator=NO;
    self.collectionView = collectionView;
}

#pragma mark - UICollectionViewDelegate && dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DLCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cardCell forIndexPath:indexPath];
    cell.imageName = self.dataList[indexPath.row][@"img"];
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _startX = scrollView.contentOffset.x;
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _endX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self cellToCenter];
    });
}
-(void)cellToCenter{
    //最小滚动距离
    float dragMinDistance = self.collectionView.bounds.size.width/20.0f;
    if (_startX - _endX >= dragMinDistance) {
        _currentIndex -= 1; //向右
    }else if (_endX - _startX >= dragMinDistance){
        _currentIndex += 1 ;//向左
    }
    NSInteger maxIndex  = [self.collectionView numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 :_currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _currentIndex = indexPath.row;
    [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - LazyLoad

- (NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@{@"name":@"工业云会员",@"img":@"vip1"},@{@"name":@"钻石会员",@"img":@"vip2"},@{@"name":@"黄金会员",@"img":@"vip3"},@{@"name":@"标准会员",@"img":@"vip4"},@{@"name":@"免费会员",@"img":@"vip5"}];
    }
    return _dataList;
}

@end
