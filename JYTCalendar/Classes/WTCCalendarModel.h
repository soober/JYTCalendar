//
//  WTCalendarModel.h
//  WisdomTree
//
//  Created by caolong on 2020/11/12.
//  Copyright © 2020 able-elec. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,WTCCalendarDay){
    WTCPastDay = 1,//过去
    WTCToday,//今天
    WTCFutureDay//未来
};

@interface WTCCalendarModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger weekday;
@property (nonatomic, assign) NSInteger currentDay;

@end



NS_ASSUME_NONNULL_END
