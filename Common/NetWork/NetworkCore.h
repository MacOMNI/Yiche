//
//  NetworkCore.h
//  homeWork
//
//  Created by wang xinkai on 15/2/5.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkCore : NSObject

//获取新闻数据
+(void)getNewsLine:(void(^)(id responseObj))block;

+ (void)getNewsList:(NSString *)url succeed:(void(^)(id responseObj))block;

+ (void)getAdsList:(NSString *)url succeed:(void(^)(id responseObj))block;

@end
