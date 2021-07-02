//
//  WTCalendarModel.m
//  WisdomTree
//
//  Created by caolong on 2020/11/12.
//  Copyright © 2020 able-elec. All rights reserved.
//

#import "WTCalendarModel.h"
#import "WTCalendarManage.h"

@implementation WTCalendarModel

@end

@implementation WTWeekMonthModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"calendarList" : [WTCalendarModel class]};
}


@end


@implementation WTMyTrainYearModel


@end

@implementation WTMyTrainWeekModel


@end
