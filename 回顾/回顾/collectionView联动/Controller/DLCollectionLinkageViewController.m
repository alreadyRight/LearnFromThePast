//
//  DLCollectionLinkageViewController.m
//  回顾
//
//  Created by bxkj on 2017/11/21.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "DLCollectionLinkageViewController.h"

@interface DLCollectionLinkageViewController ()

@end

@implementation DLCollectionLinkageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联动";
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *str = @"<p>为群殴IQ我记得群殴我寄刀片群殴我记得</p><p><img src=\"asdasdasdas\" style=\"height: 444;width: 333\"></p>";
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:str];
    NSData *data = [attr dataFromRange:NSMakeRange(0, attr.length) documentAttributes:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} error:nil];
    NSLog(@"%@",data);
    str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    UITextView *textView = [[UITextView alloc]init];
    textView.attributedText = attr;
}

@end
