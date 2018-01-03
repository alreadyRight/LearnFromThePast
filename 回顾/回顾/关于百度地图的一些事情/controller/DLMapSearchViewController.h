//
//  DLMapSearchViewController.h
//  回顾
//
//  Created by 周冰烽 on 2018/1/3.
//  Copyright © 2018年 devil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface DLMapSearchViewController : UIViewController

@property(nonatomic,copy) NSString *cityName;

@property(nonatomic,copy) void(^chooseAddress)(CLLocationCoordinate2D pt);

@end
