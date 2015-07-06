//
//  WeiboCellConfig.h
//  SinaWeibo
//
//  Created by imac on 15-4-13.
//  Copyright (c) 2015年 Xin the Great. All rights reserved.
//

/*
 编程思想 功能单一化，
 
 
 根据数据和配置参数 直接计算出cell的高度
 
 */


#import <Foundation/Foundation.h>
//#import "WeiboModel.h"
#import "CheyouHomeModel.h"
//#import "WeiboView.h"
#import "CheYouView.h"

@interface WeiboCellConfig : NSObject

//统一配置文本信息
+ (NSDictionary *)attributesForContentLabel;
//+ (CGFloat)getWeiboCellHeight:(WeiboModel *)model;
+ (CGFloat)getWeiboCellHeight:(CheyouHomeModel *)model;


///设置参数

+(void)setOffset:(CGFloat)off;

+(void)setWeiboImageHeight:(CGFloat)h;

//创建Label
+ (CNLabel *)createLabel;
@end
