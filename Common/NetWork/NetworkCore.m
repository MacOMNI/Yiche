//
//  NetworkCore.m
//  homeWork
//
//  Created by wang xinkai on 15/2/5.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import "NetworkCore.h"
#import "CNHttpRequest.h"


@implementation NetworkCore




//获取好友以及自己的最新微博
+(void)getNewsLine:(void(^)(id responseObj))block{
    
    
    NSString*url = @"http://api.ycapp.yiche.com/appnews/toutiaov51/?page=1&pagesize=20&platform=2";
    
    [CNHttpRequest httpRequestWithURL:url params:nil httpMethod:@"GET" succeedBlock:^(id responseObj) {
       
        
        block(responseObj);
        
    } failBlock:^(NSHTTPURLResponse *response) {
        
        NSLog(@"RRRRR");
    }];
    
}

+ (void)getNewsList:(NSString *)url succeed:(void(^)(id responseObj))block{

    [CNHttpRequest httpRequestWithURL:url params:nil httpMethod:@"GET" succeedBlock:^(id responseObj) {
        
        
        block(responseObj);
        
    } failBlock:^(NSHTTPURLResponse *response) {
        
       
        
    }];

    
}

+ (void)getAdsList:(NSString *)url succeed:(void(^)(id responseObj))block{

    [CNHttpRequest httpRequestWithURL:url params:nil httpMethod:@"GET" succeedBlock:^(id responseObj) {
        
        
        block(responseObj);
        
    } failBlock:^(NSHTTPURLResponse *response) {
        
        
        
    }];

}


@end
