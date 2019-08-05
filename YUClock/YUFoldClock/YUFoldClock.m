//
//  YUFoldClock.m
//  翻页动画
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import "YUFoldClock.h"
#import "YUFoldClockItem.h"

@interface YUFoldClock ()

/*! NOTE: 时 */
@property (nonatomic, strong) YUFoldClockItem *hourItem;

/*! NOTE: 分 */
@property (nonatomic, strong) YUFoldClockItem *minuteItem;

/*! NOTE: 秒 */
@property (nonatomic, strong) YUFoldClockItem *secondItem;

@end

@implementation YUFoldClock

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.backgroundColor = [UIColor blackColor];
    
    [self addSubview:self.hourItem];
    
    [self addSubview:self.minuteItem];
    
    [self addSubview:self.secondItem];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin = 0.07 * CGRectGetWidth(self.bounds);
    CGFloat itemW = (CGRectGetWidth(self.bounds) - 4 * margin) / 3.0f;
    CGFloat itemY = (CGRectGetHeight(self.bounds) - itemW) / 2.0f;
    
    self.hourItem.frame = CGRectMake(margin, itemY, itemW, itemW);
    self.minuteItem.frame = CGRectMake(CGRectGetMaxX(self.hourItem.frame) + margin, itemY, itemW, itemW);
    self.secondItem.frame = CGRectMake(CGRectGetMaxX(self.minuteItem.frame) + margin, itemY, itemW, itemW);
}

#pragma mark ========= setter =========
- (void)setDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    _hourItem.time = dateComponent.hour;
    _minuteItem.time = dateComponent.minute;
    _secondItem.time = dateComponent.second;
}

- (void)setFont:(UIFont *)font {
    _hourItem.font = font;
    _minuteItem.font = font;
    _secondItem.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _hourItem.textColor = textColor;
    _minuteItem.textColor = textColor;
    _secondItem.textColor = textColor;
}

#pragma mark ========= lazy load =========
/*! NOTE: 时 */
-(YUFoldClockItem *)hourItem {
    if (!_hourItem) {
        _hourItem = [[YUFoldClockItem alloc] init];
        _hourItem.type = YUClockItemTypeHour;
    }
    return _hourItem;
}

/*! NOTE: 分 */
-(YUFoldClockItem *)minuteItem {
    if (!_minuteItem) {
        _minuteItem = [[YUFoldClockItem alloc] init];
        _minuteItem.type = YUClockItemTypeHour;
    }
    return _minuteItem;
}

/*! NOTE: 秒 */
-(YUFoldClockItem *)secondItem {
    if (!_secondItem) {
        _secondItem = [[YUFoldClockItem alloc] init];
        _secondItem.type = YUClockItemTypeHour;
    }
    return _secondItem;
}

@end
