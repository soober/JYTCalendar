//
//  WTCalendarModel.h
//  WisdomTree
//
//  Created by caolong on 2020/11/12.
//  Copyright © 2020 able-elec. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,WTCalendarCurrentDay){
    WTPastDay = 1,//过去
    WTToday,//今天
    WTFutureDay//未来
};

typedef NS_ENUM(NSUInteger,WTCalendarCurrentMonth){
    WTPastMonth = 1,//过去月
    WTCurrentMonth,//当月
    WTFutureMonth//未来月
};

@interface WTCalendarModel : NSObject

@property (nonatomic,copy) NSString *date;
@property (nonatomic,assign)NSInteger year;
@property (nonatomic,assign)NSInteger month;
@property (nonatomic,assign)NSInteger day;
@property (nonatomic,assign)NSInteger weekday;
@property (nonatomic,assign) BOOL isSign;//是否打卡
@property (nonatomic,assign) NSInteger currentDay;//过去今天未来

@property (nonatomic,assign) NSInteger currentMonth;//当月
@property (nonatomic, strong) NSIndexPath *indexP;
@property (nonatomic, assign) BOOL selected;

@end

@interface WTWeekMonthModel : NSObject

@property (nonatomic,assign) NSInteger signCount;//已签到天数
@property (nonatomic,strong) NSArray <WTCalendarModel *> *calendarList;//某月的全部日期集合
@property (nonatomic, copy) NSString *selectedMonthStr;//eg: 2021.10

@end

// 我的训练 日历月查询
@interface WTMyTrainYearModel : NSObject

@property (nonatomic,strong) NSArray <WTCalendarModel *> *monthList;//一年的全部月份
@property (nonatomic, copy) NSString *selectedYearStr;//eg: 2021

@end

// 我的训练 日历周查询
@interface WTMyTrainWeekModel : NSObject

@property (nonatomic, strong) NSArray <WTCalendarModel *> *calendarList;//某月的全部日期集合
@property (nonatomic, copy) NSString *weekDurationStr;// eg: 2021/10/18 - 2021/10/24

@end

NS_ASSUME_NONNULL_END
