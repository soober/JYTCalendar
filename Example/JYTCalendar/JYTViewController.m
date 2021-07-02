//
//  JYTViewController.m
//  JYTCalendar
//
//  Created by soober on 07/02/2021.
//  Copyright (c) 2021 soober. All rights reserved.
//

#import "JYTViewController.h"
#import <WTCalendarManage.h>

@interface JYTViewController ()

@end

@implementation JYTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSInteger count = [[WTCalendarManage sharedManage] getCountOfMonthByDate:[NSDate date]];
    NSLog(@"当月有几天 : %ld", (long)count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
