//
//  YUFoldClockItem.h
//  翻页动画
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YUFoldClockItemType) {
    YUClockItemTypeHour = 0,
    YUClockItemTypeMinute,
    YUClockItemTypeSecond,
};

@interface YUFoldClockItem : UIView

@property (nonatomic, assign) YUFoldClockItemType type;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *textColor;

@end

NS_ASSUME_NONNULL_END
