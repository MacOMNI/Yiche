//
//  WeiboCellConfig.m
//  SinaWeibo
//
//  Created by imac on 15-4-13.
//  Copyright (c) 2015年 Xin the Great. All rights reserved.
//

#import "WeiboCellConfig.h"

#import "WBImageView.h"
static CGFloat kWeiboCelloffset = 50;
static CGFloat kWeiboImageH = 85;
static CGFloat kWeiboViewTextW = 300;
static CGFloat kReWeiboViewTextW = 270;
static CGFloat kReWeiboViewW = 270+40;

@implementation WeiboCellConfig

//设置contentLabel
+ (NSDictionary *)attributesForContentLabel{

    return @{NSFontAttributeName:[UIFont systemFontOfSize:16]};

}
+ (void)setWeiboImageHeight:(CGFloat)h{

    kWeiboImageH = h;

}
+ (void)setOffset:(CGFloat)off{

    kWeiboCelloffset = off;
}
+ (CGFloat)getWeiboCellHeight:(CheyouHomeModel *)model{

    CGFloat weiboHeight = [self getWeiboViewHeight:model repost:NO];
    return weiboHeight + kWeiboCelloffset;
    
}
//通过数据 直接返回高度
+ (CGFloat)getWeiboViewHeight:(CheyouHomeModel *)weiboModel repost:(BOOL)isrepost{

    CNLabel *label = [self createLabel];
    if (isrepost) {
        label.width = kReWeiboViewTextW;
    }
    label.text = [NSString stringWithFormat:@"%@",weiboModel.content];
    CGFloat height = label.height;
    
    //判断图片
    if (weiboModel.imageList.count) {
        height += [WBImageView heightForCount:(int)weiboModel.imageList.count];
        height += 20;
    }
    return height +20;
}
+ (CNLabel *)createLabel{

    CNLabel *label = [[CNLabel alloc]initWithFrame:CGRectMake(20, 10, kWeiboViewTextW -10, 10)];
    label.textAttributes = [self attributesForContentLabel];
    return label;
}


@end
