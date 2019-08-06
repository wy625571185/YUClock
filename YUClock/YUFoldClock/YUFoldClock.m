//
//  YUFoldClock.m
//  翻页动画
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import "YUFoldClock.h"
#import "YUFoldClockItem.h"
#import "NSDate+YUAdd.h"

@interface YUFoldClock ()

/*! NOTE: 日期 */
@property (nonatomic, strong) UILabel *dateLabel;

/*! NOTE: 时 */
@property (nonatomic, strong) YUFoldClockItem *hourItem;

/*! NOTE: 分 */
@property (nonatomic, strong) YUFoldClockItem *minuteItem;

/*! NOTE: 秒 */
@property (nonatomic, strong) YUFoldClockItem *secondItem;

/*! NOTE: 上午/下午 */
@property (nonatomic, strong) UILabel *alertLabel;

/*! NOTE: 农历 */
@property (nonatomic, strong) UILabel *lunarCalendarLabel;

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
    
    /*! NOTE: 日期 */
    [self addSubview:self.dateLabel];
    /*! NOTE: 上下午 */
    [self addSubview:self.alertLabel];
    /*! NOTE: 时 */
    [self addSubview:self.hourItem];
    /*! NOTE: 分 */
    [self addSubview:self.minuteItem];
    /*! NOTE: 秒 */
    [self addSubview:self.secondItem];
    /*! NOTE: 农历 */
    [self addSubview:self.lunarCalendarLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin = 0.03 * CGRectGetWidth(self.bounds);
    CGFloat secondW = 80;
    CGFloat itemW = (CGRectGetWidth(self.bounds) - 4 * margin - secondW) / 2.0f;
    CGFloat itemY = (CGRectGetHeight(self.bounds) - itemW) / 2.0f;
    
    /*! NOTE: 日期 */
    self.dateLabel.frame = CGRectMake(margin + 5, itemY - 35, CGRectGetWidth(self.bounds) - 2 * margin - 10, 30);
    
    /*! NOTE: 时 */
    self.hourItem.frame = CGRectMake(margin, itemY, itemW, itemW);
    self.hourItem.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:itemW - 5];
    /*! NOTE: 分 */
    self.minuteItem.frame = CGRectMake(CGRectGetMaxX(self.hourItem.frame) + margin, itemY, itemW, itemW);
    self.minuteItem.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:itemW - 5];
    /*! NOTE: 秒 */
    self.secondItem.frame = CGRectMake(CGRectGetMaxX(self.minuteItem.frame) + margin, CGRectGetMaxY(self.minuteItem.frame) - secondW, secondW, secondW);
    self.secondItem.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:secondW - 5];
    
    /*! NOTE: 上下午 */
    self.alertLabel.frame = CGRectMake(CGRectGetMaxX(self.minuteItem.frame), itemY, secondW + 2 * margin, secondW);
    
    /*! NOTE: 农历 */
    self.lunarCalendarLabel.frame = CGRectMake(CGRectGetMinX(self.dateLabel.frame), itemY + itemW + 10, CGRectGetWidth(self.dateLabel.frame), CGRectGetHeight(self.dateLabel.frame));
}

#pragma mark ========= setter =========
- (void)setDate:(NSDate *)date {
    /*! NOTE: 日期 */
    NSString *dateStr = dateStrWithDate(date, @"yyyy年MM月dd日");
    if (![_dateLabel.text isEqualToString:dateStr]) {
        _dateLabel.text = dateStr;
    }

    /*! NOTE: 设置上下午 */
    if (![_alertLabel.text isEqualToString:date.yu_AMOrPM]) {
        _alertLabel.text = date.yu_AMOrPM;
    }
    /*! NOTE: 时 */
    _hourItem.time = date.yu_hour;
    /*! NOTE: 分 */
    _minuteItem.time = date.yu_minute;
    /*! NOTE: 秒 */
    _secondItem.time = date.yu_second;
    
    /*! NOTE: 农历 */
    NSString *lunarDateStr = [NSString stringWithFormat:@"%@    %@", date.yu_lunarCalendarYearStr, date.yu_lunarCalendarMonthDayStr];
    if (![_lunarCalendarLabel.text isEqualToString:lunarDateStr]) {
        _lunarCalendarLabel.text = lunarDateStr;
    }
}

- (void)setFont:(UIFont *)font {
    _hourItem.font = font;
    _minuteItem.font = font;
    _secondItem.font = [UIFont fontWithName:@"AmericanTypewriter-Condensed" size:75];
}

- (void)setTextColor:(UIColor *)textColor {
    _hourItem.textColor = textColor;
    _minuteItem.textColor = textColor;
    _secondItem.textColor = textColor;
}

#pragma mark ========= lazy load =========
/*! NOTE: 日期 */
-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor colorWithRed:186/255.0f green:183/255.0f blue:186/255.0f alpha:1];
        _dateLabel.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:25];
        _dateLabel.text = @"";
    }
    return _dateLabel;
}

/*! NOTE: 上午/下午 */
-(UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.textColor = [UIColor colorWithRed:186/255.0f green:183/255.0f blue:186/255.0f alpha:1];
        _alertLabel.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:50];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.text = @"";
    }
    return _alertLabel;
}

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
        _secondItem.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:75];
    }
    return _secondItem;
}

/*! NOTE: 农历 */
-(UILabel *)lunarCalendarLabel {
    if (!_lunarCalendarLabel) {
        _lunarCalendarLabel = [[UILabel alloc] init];
        _lunarCalendarLabel.textColor = [UIColor colorWithRed:186/255.0f green:183/255.0f blue:186/255.0f alpha:1];
        _lunarCalendarLabel.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:25];
        _lunarCalendarLabel.text = @"";
        _lunarCalendarLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lunarCalendarLabel;
}

@end
