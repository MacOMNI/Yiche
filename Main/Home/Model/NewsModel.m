//
//  NewsModel.m
//  YiChe
//
//  Created by imac on 15-4-28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

//用字符串查找、拼接方法加载新闻图片
-(void)setPicCover:(NSString *)picCover{

    NSRange range = [picCover rangeOfString:@"{0}"];
    
    if (range.location != NSNotFound) {
        
        NSString *picUrl = [picCover stringByReplacingOccurrencesOfString:@"{0}" withString:@"180"];
        NSString *picUrl1 = [picUrl stringByReplacingOccurrencesOfString:@"{1}" withString:@"40"];
        _picCover = picUrl1;
        return;
    }
    _picCover = picCover;
}

    

@end
