//
//  NSDate+YUAdd.m
//  YUClock
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import "NSDate+YUAdd.h"

@implementation NSDate (YUAdd)

/*! NOTE: 年 */
- (NSInteger ) yu_year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitYear fromDate:self];
    return dateComponent.year;
}

/*! NOTE: 月 */
- (NSInteger ) yu_month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitMonth fromDate:self];
    return dateComponent.month;
}

/*! NOTE: 周 */
- (NSInteger ) yu_week {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return dateComponent.weekday;
}

/*! NOTE: 日 */
- (NSInteger ) yu_day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitDay fromDate:self];
    return dateComponent.day;
}

/*! NOTE: 时 */
- (NSInteger ) yu_hour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitHour fromDate:self];
    return dateComponent.hour;
}

/*! NOTE: 分 */
- (NSInteger ) yu_minute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitMinute fromDate:self];
    return dateComponent.minute;
}

/*! NOTE: 秒 */
- (NSInteger ) yu_second {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitSecond fromDate:self];
    return dateComponent.second;
}

/*! NOTE: 上午/下午 */
- (NSString *)yu_AMOrPM {
    /*! NOTE: 设置上下午 */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.AMSymbol = @"上午";
    dateFormatter.PMSymbol = @"下午";
    [dateFormatter setDateFormat:@"a"];
    return [dateFormatter stringFromDate:self];
}

/*! NOTE: Date转成字符串 */
NSString *dateStrWithDate(NSDate *date, NSString *dateFormat) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

/*! NOTE: 转换成农历 */
-(NSString *)yu_lunarCalendarYearStr {
    /*! NOTE: 获取数据 */
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"YUConfig" ofType:@"plist"];
    NSDictionary *listDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *chineseYears = listDic[@"lunarCalendarYears"];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year - 1];
    
    NSString *Cz_str = nil;
    if ([y_str hasSuffix:@"子"]) {
        Cz_str = @"鼠";
    }else if ([y_str hasSuffix:@"丑"]){
        Cz_str = @"牛";
    }else if ([y_str hasSuffix:@"寅"]){
        Cz_str = @"虎";
    }else if ([y_str hasSuffix:@"卯"]){
        Cz_str = @"兔";
    }else if ([y_str hasSuffix:@"辰"]){
        Cz_str = @"龙";
    }else if ([y_str hasSuffix:@"巳"]){
        Cz_str = @"蛇";
    }else if ([y_str hasSuffix:@"午"]){
        Cz_str = @"马";
    }else if ([y_str hasSuffix:@"未"]){
        Cz_str = @"羊";
    }else if ([y_str hasSuffix:@"申"]){
        Cz_str = @"猴";
    }else if ([y_str hasSuffix:@"酉"]){
        Cz_str = @"鸡";
    }else if ([y_str hasSuffix:@"戌"]){
        Cz_str = @"狗";
    }else if ([y_str hasSuffix:@"亥"]){
        Cz_str = @"猪";
    }
    
    return  [NSString stringWithFormat:@"%@(%@)年", y_str, Cz_str];
}

/*! NOTE: 农历的月、日 */
-(NSString *)yu_lunarCalendarMonthDayStr {
    /*! NOTE: 获取数据 */
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"YUConfig" ofType:@"plist"];
    NSDictionary *listDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    /*! NOTE: 农历月 */
    NSArray *chineseMonths = listDic[@"lunarCalendarMonths"];
    /*! NOTE: 农历日 */
    NSArray *chineseDays = listDic[@"lunarCalendarDays"];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month - 1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day - 1];
    NSString *chineseCal_str =[NSString stringWithFormat:@"%@%@", m_str, d_str];
    
    return chineseCal_str;
}

/*! NOTE: 周几 */
-(NSString *)yu_weekDayStr {
    /*! NOTE: 只适用于iOS8 */
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitWeekday fromDate:self];
    NSString *str = [NSString stringWithFormat:@"%@", @(dateComponents.weekday)];
    
    if ([str  isEqual: @"1"]) {
        return @"周日";
    }else if ([str isEqual:@"2"]){
        return @"周一";
    }else if ([str isEqual:@"3"]){
        return @"周二";
    }else if ([str isEqual:@"4"]){
        return @"周三";
    }else if ([str isEqual:@"5"]){
        return @"周四";
    }else if ([str isEqual:@"6"]){
        return @"周五";
    }else{
        return @"周六";
    }
}

@end
