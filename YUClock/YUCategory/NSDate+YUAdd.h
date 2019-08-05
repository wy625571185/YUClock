//
//  NSDate+YUAdd.h
//  YUClock
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (YUAdd)

/*! NOTE: 年 */
@property (nonatomic, assign, readonly) NSInteger yu_year;
/*! NOTE: 月 */
@property (nonatomic, assign, readonly) NSInteger yu_month;
/*! NOTE: 周 */
@property (nonatomic, assign, readonly) NSInteger yu_week;
/*! NOTE: 日 */
@property (nonatomic, assign, readonly) NSInteger yu_day;
/*! NOTE: 时 */
@property (nonatomic, assign, readonly) NSInteger yu_hour;
/*! NOTE: 分 */
@property (nonatomic, assign, readonly) NSInteger yu_minute;
/*! NOTE: 秒 */
@property (nonatomic, assign, readonly) NSInteger yu_second;

/*! NOTE: 上午/下午 */
@property (nonatomic, strong, readonly) NSString *yu_AMOrPM;

/*! NOTE: Date转成字符串 */
NSString *dateStrWithDate(NSDate *date, NSString *dateFormat);

/*! NOTE: 转换成农历 */
@property (nonatomic, strong, readonly) NSString *yu_lunarCalendarYearStr;

/*! NOTE: 农历的月、日 */
@property (nonatomic, strong, readonly) NSString *yu_lunarCalendarMonthDayStr;

/*! NOTE: 周几 */
@property (nonatomic, strong, readonly) NSString *yu_weekDayStr;

@end

NS_ASSUME_NONNULL_END
