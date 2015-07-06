//
//  VideoModel.m
//  YiChe
//
//  Created by imac on 15-5-3.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (void)setImageLink:(NSString *)ImageLink
{
    NSRange range1 = [ImageLink rangeOfString:@"{0}"];
    
    if (range1.location != NSNotFound) {
        
        NSString *newURL = [ImageLink stringByReplacingOccurrencesOfString:@"{0}" withString:@"180"];
        NSString *newURL1 = [newURL stringByReplacingOccurrencesOfString:@"{1}" withString:@"40"];

        _ImageLink = newURL1;
        
        return;
        
    }
    
    _ImageLink = ImageLink;
    
}

@end
