//
//  WTCalendarManage.m
//  WisdomTree
//
//  Created by caolong on 2020/11/7.
//  Copyright © 2020 able-elec. All rights reserved.
//

#import "WTCalendarManage.h"
#import "NSDate+Category.h"

@interface WTCalendarManage ()

@property (nonatomic,strong) NSDateFormatter *calendarFormatter;
@property (nonatomic,strong) NSCalendar *curCalendar;

@end

static WTCalendarManage *_calendarManage;

@implementation WTCalendarManage

+ (instancetype)sharedManage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _calendarManage = [[WTCalendarManage alloc]init];
    });
    return _calendarManage;
}

- (NSDateFormatter *)calendarFormatter {
    if (!_calendarFormatter) {
        _calendarFormatter = [[NSDateFormatter alloc]init];
        [_calendarFormatter setDateFormat:@"yyyy-MM-dd"];
        [_calendarFormatter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    }
    return _calendarFormatter;
}

- (NSCalendar *)curCalendar {
    if (!_curCalendar) {
        _curCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        _curCalendar.firstWeekday = 2;//设置周一为一周的第一天显示
    }
    return _curCalendar;
}

- (NSInteger)getCountOfMonthByDate:(NSDate *)date {
    
    if (date) {
        return [self.curCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    }
    return 0;
}

- (NSInteger)getCountOfLastMonthByDate:(NSDate *)date {
    
    if (date) {
        NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *components = [self.curCalendar components:dayInfoUnits fromDate:date];
        components.day = 1;
        components.month--;
        NSDate * lastMonthDate =[self.curCalendar dateFromComponents:components];
        return [self getCountOfMonthByDate:lastMonthDate];
    }
    return 0;
}

- (NSInteger)getCountOfNextMonthByDate:(NSDate *)date {
    if (date) {
        NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *components = [self.curCalendar components:dayInfoUnits fromDate:date];
        components.day = 1;
        components.month++;
        NSDate * lastMonthDate =[self.curCalendar dateFromComponents:components];
        return [self getCountOfMonthByDate:lastMonthDate];
    }
    return 0;
}


- (NSInteger)getDayFirstOfMonthWeekByDate:(NSDate *)date {
    if (date) {
        NSDate *mondayDate = [self getDayFirstOfMonthByDate:date];
        NSDateComponents *comps = [self.curCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:mondayDate];
        return [comps weekday];
    }
    return 0;
}

// 获取某个月1号时间
- (NSDate *)getDayFirstOfMonthByDate:(NSDate *)date {
    if (date) {
        NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *comps = [self.curCalendar components:dayInfoUnits fromDate:date];
        comps.day = 1;
        NSDate *firstDate = [self.curCalendar dateFromComponents:comps];
        return firstDate;
    }
    return nil;
}

- (NSDate *)getDayFirstOfLastMonthByDate:(NSDate *)date {
    if (date) {
        NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *comps = [self.curCalendar components:dayInfoUnits fromDate:date];
        comps.day = 1;
        comps.month--;
        NSDate *firstDate = [self.curCalendar dateFromComponents:comps];
        return firstDate;
    }
    return nil;
}

- (NSDate *)getDayFirstOfNextMonthByDate:(NSDate *)date {
    if (date) {
        NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *comps = [self.curCalendar components:dayInfoUnits fromDate:date];
        comps.day = 1;
        comps.month++;
        NSDate *firstDate = [self.curCalendar dateFromComponents:comps];
        return firstDate;
    }
    return nil;
}

// 获取日期date对应月的第一天日期
- (NSString *)getMonthFirstDayWithDate:(NSDate *)date format:(NSString *)aformat {
    NSDate *newDate = date;
    double interval = 0;
    NSDate *firstDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL bl = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    if (bl) {
        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:aformat];
        NSString *firstString = [myDateFormatter stringFromDate: firstDate];
        return firstString;
    }
    return @"";
}
// 获取日期date对应月的最后一天日期
- (NSString *)getMonthLastDayWithDate:(NSDate *)date format:(NSString *)aformat {
    NSDate *newDate = date;
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL bl = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    if (bl) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:aformat];
        NSString *lastString = [myDateFormatter stringFromDate: lastDate];
        return lastString;
    }
    return @"";
}

#pragma - mark 周末判断
- (NSDate *)getMondayOfWeekByDate:(NSDate *)date {
    if (date) {
        NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        NSDateComponents *comps = [self.curCalendar components:dayInfoUnits fromDate:date];
        NSInteger weekDay = [comps weekday];
        NSInteger day = [comps day];
        NSInteger countDays = 0;
        
        if (self.curCalendar.firstWeekday > weekDay) {
            countDays = 7 + (weekDay - self.curCalendar.firstWeekday);
        } else {
            countDays = weekDay - self.curCalendar.firstWeekday;
        }
        
        NSDateComponents *firstComponents = [self.curCalendar components:dayInfoUnits fromDate:date];
        firstComponents.day = day-countDays;
        NSDate *firstDate = [self.curCalendar dateFromComponents:firstComponents];
        
        return firstDate;
    }
    return nil;
}

- (NSDate *)getSundayOfWeekByDate:(NSDate *)date {
    if (date) {
        NSDate *mondayDate = [self getMondayOfWeekByDate:date];
        
        NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        NSDateComponents *lastComponents = [self.curCalendar components:dayInfoUnits fromDate:mondayDate];
        lastComponents.day = lastComponents.day+6;
        NSDate *lastDate = [self.curCalendar dateFromComponents:lastComponents];
        return lastDate;
    }
    return nil;
}

- (NSArray <WTCalendarModel *>*)getDayOfWeekByDate:(NSDate *)date {
    if (date) {
        NSDate *mondayDate = [self getMondayOfWeekByDate:date];
        NSCalendarUnit dayInfoUnits  = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday;

        NSDateComponents *mondayComponents = [self.curCalendar components:dayInfoUnits fromDate:mondayDate];
        NSMutableArray *dateArr = [NSMutableArray array];
        for (int i = 0; i<7; i++) {
            WTCalendarModel *model = [[WTCalendarModel alloc]init];
            NSDate *dayD = [self.curCalendar dateFromComponents:mondayComponents];
            model.date = [self.calendarFormatter stringFromDate:dayD];
            NSDateComponents *cDate = [self currentComByDate:dayD];
            NSLog(@"---cur comps :%@",cDate);
            model.year = cDate.year;
            model.month = cDate.month;
            model.day = cDate.day;
            model.weekday = cDate.weekday;
            NSComparisonResult result = [self compareDate:dayD anotherDate:date];
            if (result == -1) {
                model.currentDay = WTPastDay;
            } else if (result == 0) {
                model.currentDay = WTToday;
            } else if (result == 1) {
                model.currentDay = WTFutureDay;
            }
            [dateArr addObject:model];
            mondayComponents.day++;
        }
        return dateArr;
    }
    return nil;
}

- (NSArray <WTCalendarModel *>*)getDayOfMonthByDate:(NSDate *)date {
    if (date) {
        NSDate *mondayDate = [self getDayFirstOfMonthByDate:date];
        NSCalendarUnit dayInfoUnits  = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday;
        NSDateComponents *mondayComponents = [self.curCalendar components:dayInfoUnits fromDate:mondayDate];
        NSMutableArray *dateArr = [NSMutableArray array];
        NSInteger dayCount = [self getCountOfMonthByDate:date];
        for (int i = 0; i<dayCount; i++) {
//            NSLog(@"---cur comps :%@",mondayComponents);
            WTCalendarModel *model = [[WTCalendarModel alloc]init];
            NSDate *dayD = [self.curCalendar dateFromComponents:mondayComponents];
            model.date = [self.calendarFormatter stringFromDate:dayD];
            model.year = mondayComponents.year;
            model.month = mondayComponents.month;
            model.day = mondayComponents.day;
            model.weekday = [self currentComByDate:dayD].weekday;
            NSComparisonResult result = [self compareDate:dayD anotherDate:[NSDate date]];
            if (result == -1) {
                model.currentDay = WTPastDay;
            } else if (result == 0) {
                model.currentDay = WTToday;
            } else if (result == 1) {
                model.currentDay = WTFutureDay;
            }
            [dateArr addObject:model];
            mondayComponents.day++;
        }
        return dateArr;
    }
    return nil;
}

- (NSComparisonResult)compareDate:(NSDate *)dateA anotherDate:(NSDate *)dateB {
    NSString *strA = [self.calendarFormatter stringFromDate:dateA];
    NSString *strB = [self.calendarFormatter stringFromDate:dateB];
    NSComparisonResult result = [[self.calendarFormatter dateFromString:strA] compare: [self.calendarFormatter dateFromString:strB]];
    return result;
}

#pragma - mark 周末判断
- (NSInteger)getRowsOfMonthByDate:(NSDate *)date {
    if (date) {
        NSInteger dayCount = [self getCountOfMonthByDate:date];
        NSInteger firstDayWeek = [self getDayFirstOfMonthWeekByDate:date];//1号周几
        NSInteger j = dayCount%7;//余数
        if (firstDayWeek == 1) {
            //周末
            if (dayCount < 30) {
                return 5;
            } else {
                return 6;
            }
        } else {
            if (j > 7-firstDayWeek+2) {
                return 6;
            } else if (j == 7-firstDayWeek+2) {
                return 5;
            } else {
                if (j == 0) {
                    return 4;
                }else{
                    return 5;
                }
            }
        }
    }
    return 0;
}

- (NSInteger)getYearBydate:(NSDate *)date {
    if (date) {
        NSDateComponents *comps = [self.curCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
        return comps.year;
    }
    return 0;
}

- (NSInteger)getMonthBydate:(NSDate *)date {
    if (date) {
        NSDateComponents *comps = [self.curCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
        return comps.month;
    }
    return 0;
}

- (NSInteger)getDayBydate:(NSDate *)date {
    if (date) {
        NSDateComponents *comps = [self.curCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
        return comps.day;
    }
    return 0;
}

- (NSDateComponents *)currentComByDate:(NSDate *)date {
    if (date) {
        NSDateComponents *comps = [self.curCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
        return comps;
    }
    return nil;
}

- (NSDate *)currentDateByComps:(NSDateComponents *)comps {
    if (comps) {
        return  [self.curCalendar dateFromComponents:comps];
    }
    return nil;
}





@end
