//
//  YUFoldLabel.h
//  翻页动画
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YUFoldLabel : UIView

- (void) updateTime:(NSInteger)time nextTime:(NSInteger)nextTime;

/*! NOTE: 字体 */
@property (nonatomic, strong) UIFont *font;

/*! NOTE: 字体颜色 */
@property (nonatomic, strong) UIColor *textColor;

@end

NS_ASSUME_NONNULL_END
