//
//  DLImageViewCollectionViewCell.m
//  回顾
//
//  Created by 周冰烽 on 2019/1/17.
//  Copyright © 2019 devil. All rights reserved.
//

#import "DLImageViewCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import <MBProgressHUD.h>
@interface DLImageViewCollectionViewCell()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView * scrollView;

@property (nonatomic, strong)UIImageView * imageView;

@end

@implementation DLImageViewCollectionViewCell

#pragma mark - TouchEvent
//双击缩放手势
- (void)doubleTap:(UITapGestureRecognizer *)tap{
	if (_scrollView.zoomScale > 1.0) {
		[_scrollView setZoomScale:1.0 animated:YES];
	} else {
		CGPoint touchPoint = [tap locationInView:_imageView];
		CGFloat scale = _scrollView.maximumZoomScale;
		CGRect newRect = [self getRectWithScale:scale andCenter:touchPoint];
		[_scrollView zoomToRect:newRect animated:YES];
	}
}

//单击返回按钮
- (void)singleTap:(UITapGestureRecognizer *)tap{
	!_singleTap ?: _singleTap();
}

- (CGRect)getRectWithScale:(CGFloat)scale andCenter:(CGPoint)center{
	CGRect newRect = CGRectZero;
	newRect.size.width =  _scrollView.frame.size.width/scale;
	newRect.size.height = _scrollView.frame.size.height/scale;
	newRect.origin.x = center.x - newRect.size.width * 0.5;
	newRect.origin.y = center.y - newRect.size.height * 0.5;
	
	return newRect;
}

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		[self setupUI];
	}
	return self;
}

- (void)setupUI {
	self.backgroundColor = [UIColor blackColor];
	_scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
	_scrollView.maximumZoomScale = 4.0;
	_scrollView.minimumZoomScale = 1.0;
	_scrollView.delegate = self;
	[self addSubview:_scrollView];
	//显示照片的imageView
	_imageView = [[UIImageView alloc]init];
	_imageView.userInteractionEnabled = YES;
	_imageView.contentMode = UIViewContentModeScaleAspectFit;
	[_scrollView addSubview:_imageView];
	
	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
	doubleTap.numberOfTapsRequired = 2;
	doubleTap.numberOfTouchesRequired  = 1;
	[_imageView addGestureRecognizer:doubleTap];
	
	
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
	singleTap.numberOfTapsRequired = 1;
	singleTap.numberOfTouchesRequired  = 1;
	[_imageView addGestureRecognizer:singleTap];
	
	[singleTap requireGestureRecognizerToFail:doubleTap];
}

- (void)setImageSource:(NSString *)imageSource{
	_imageSource = imageSource;
	[self loadImage];
}

- (void)loadImage {
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
	hud.mode = MBProgressHUDModeAnnularDeterminate;
	hud.label.text = @"正在加载...";
	WK(weakSelf);
	NSURL *url = [NSURL URLWithString:self.imageSource];
	[_imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
		NSLog(@"%zd",receivedSize);
		dispatch_async(dispatch_get_main_queue(), ^{
			hud.progress = (receivedSize * 1.00) / (expectedSize * 1.00);
		});
	} completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
		//如果图片下载失败 则直接返回
		if (image == nil) {
			return ;
		}
		[hud hideAnimated:YES];
		weakSelf.imageView.image = image;
		[weakSelf setImagePosition:image];
	}];
}

- (void)setImagePosition:(UIImage *)image {
	_imageView.frame = CGRectMake(0, 40, kScreenWidth, kScreenHeight - 80);
	_scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
	CGRect frame = _imageView.frame;
	
	frame.origin.y = (_scrollView.frame.size.height - _imageView.frame.size.height) > 0 ? (_scrollView.frame.size.height - _imageView.frame.size.height) * 0.5 : 0;
	frame.origin.x = (_scrollView.frame.size.width - _imageView.frame.size.width) > 0 ? (_scrollView.frame.size.width - _imageView.frame.size.width) * 0.5 : 0;
	_imageView.frame = frame;
	
	self.scrollView.contentSize = CGSizeMake(_imageView.frame.size.width, _imageView.frame.size.height + 30);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _imageView;
}

@end
