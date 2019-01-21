//
//  DLImageViewCollectionViewCell.h
//  回顾
//
//  Created by 周冰烽 on 2019/1/17.
//  Copyright © 2019 devil. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLImageViewCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy)NSString * imageSource;

@property(nonatomic,copy) void(^singleTap)(void);

@end

NS_ASSUME_NONNULL_END
