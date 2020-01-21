//
//  DLOpenAttachmentViewController.m
//  回顾
//
//  Created by 周冰烽 on 2019/1/16.
//  Copyright © 2019 devil. All rights reserved.
//

#import "DLOpenAttachmentViewController.h"

@interface DLOpenAttachmentViewController ()<UIWebViewDelegate>

@end

@implementation DLOpenAttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = self.attachmentName;
	[self readDocfile];
}

- (void)readDocfile{
	NSString * ducumentLocation = [[NSBundle mainBundle]pathForResource:@"测试11.doc" ofType:nil];
	NSLog(@"%@",ducumentLocation);
	NSURL *url = [NSURL fileURLWithPath:ducumentLocation];
	
	UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
	webView.delegate = self;
	webView.multipleTouchEnabled = YES;
	webView.scalesPageToFit = YES;
	
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[webView loadRequest:request];
	
	[self.view addSubview:webView];
}

@end
