//
//  DLImageViewerViewController.m
//  回顾
//
//  Created by 周冰烽 on 2019/1/17.
//  Copyright © 2019 devil. All rights reserved.
//

#import "DLImageViewerViewController.h"
#import <UIImageView+WebCache.h>
#import "DLImageViewerFlowLayout.h"
#import "DLImageViewCollectionViewCell.h"
static NSString * imageViewerCell = @"imageViewerCell";
@interface DLImageViewerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak)UICollectionView * collectionView;

@property (nonatomic, weak)UIPageControl *pageControl;

@end

@implementation DLImageViewerViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
}



- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor blackColor];
	self.automaticallyAdjustsScrollViewInsets = NO;
	[self setupUI];
	
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
	UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[[DLImageViewerFlowLayout alloc]init]];
	collectionView.delegate = self;
	collectionView.dataSource = self;
	[collectionView registerClass:[DLImageViewCollectionViewCell class] forCellWithReuseIdentifier:imageViewerCell];
	[self.view addSubview:collectionView];
	UIPageControl *pageControl = [[UIPageControl alloc] init];
	[collectionView addSubview:pageControl];
	[pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(self.view).offset(-20);
		make.centerX.equalTo(self.view);
		make.width.mas_equalTo(@100);
		make.height.mas_equalTo(@20);
	}];
	pageControl.numberOfPages = self.imageSource.count;
	pageControl.currentPage = 0;
	pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
	pageControl.pageIndicatorTintColor = [UIColor grayColor];
	pageControl.hidesForSinglePage = YES;
	self.pageControl = pageControl;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.imageSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	DLImageViewCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:imageViewerCell forIndexPath:indexPath];
	item.imageSource = self.imageSource[indexPath.row];
	item.singleTap = ^{
		[self.navigationController popViewControllerAnimated:YES];
	};
	return item;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	NSInteger page = 0;
	page = scrollView.contentOffset.x / kScreenWidth;
	self.pageControl.currentPage = page;
}



@end
