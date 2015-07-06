//
//  ActivitiesModel.m
//  YiChe
//
//  Created by imac on 15-5-7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ActivitiesModel.h"
//#import "Utils.h"

@implementation ActivitiesModel

- (void)setStart_data:(NSString *)start_data
{
  _start_data = [self setTime:start_data];
}

- (void)setEnd_data:(NSString *)end_data
{
    _end_data = [self setTime:end_data];
}

- (NSString *)setTime:(NSString *)timeStr
{
    NSString *formate = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [Utils dateFromString:timeStr formate:formate];
  
    return [Utils stringFromDate:date formate:@"yyyy.MM.dd"];
}

@end
