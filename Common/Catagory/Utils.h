//
//  Utils.h
//  SinaWeibo
//
//  Created by wang xinkai on 15/4/13.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject


+(NSString*)formatString:(NSString*)timeString;
+(NSDate *)dateFromString:(NSString *)timeString formate:(NSString*)formate;
+(NSString *)stringFromDate:(NSDate *)date formate:(NSString*)formate;
@end
