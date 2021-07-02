//
//  WTCalendarManage.h
//  WisdomTree
//
//  Created by caolong on 2020/11/7.
//  Copyright © 2020 able-elec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTCalendarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WTCalendarManage : NSObject

+ (instancetype)sharedManage;

// 获取某个月有几天
- (NSInteger)getCountOfMonthByDate:(NSDate *)date;

// 获取上个月有几天
- (NSInteger)getCountOfLastMonthByDate:(NSDate *)date;



// 获取下个月有几天
- (NSInteger)getCountOfNextMonthByDate:(NSDate *)date;



// 获取某个月1号是周几
- (NSInteger)getDayFirstOfMonthWeekByDate:(NSDate *)date;

// 获取某个月1号时间
- (NSDate *)getDayFirstOfMonthByDate:(NSDate *)date;
// 获取上个月1号时间
- (NSDate *)getDayFirstOfLastMonthByDate:(NSDate *)date;
// 获取下个月1号时间
- (NSDate *)getDayFirstOfNextMonthByDate:(NSDate *)date;

// 获取日期date对应月的第一天日期
- (NSString *)getMonthFirstDayWithDate:(NSDate *)date format:(NSString *)aformat;
// 获取日期date对应月的最后一天日期
- (NSString *)getMonthLastDayWithDate:(NSDate *)date format:(NSString *)aformat;


// 获取本周的开始时间
- (NSDate *)getMondayOfWeekByDate:(NSDate *)date;
// 获取本周的结束时间
- (NSDate *)getSundayOfWeekByDate:(NSDate *)date;

// 获取某周的时间数组
- (NSArray <WTCalendarModel *>*)getDayOfWeekByDate:(NSDate *)date;

// 获取某月的时间数组
- (NSArray <WTCalendarModel *>*)getDayOfMonthByDate:(NSDate *)date;

// 获取某个月有几行显示
- (NSInteger)getRowsOfMonthByDate:(NSDate *)date;

// 获取年份
- (NSInteger)getYearBydate:(NSDate *)date;
// 获取月份
- (NSInteger)getMonthBydate:(NSDate *)date;
// 获取日
- (NSInteger)getDayBydate:(NSDate *)date;

- (NSDateComponents *)currentComByDate:(NSDate *)date;
- (NSDate *)currentDateByComps:(NSDateComponents *)comps;



@end

NS_ASSUME_NONNULL_END
