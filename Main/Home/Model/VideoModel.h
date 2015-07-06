//
//  VideoModel.h
//  YiChe
//
//  Created by imac on 15-5-3.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (assign)NSInteger VideoId; //视频ID
@property (nonatomic, copy) NSString *Title; //标题
@property (nonatomic, copy) NSString *PlayLink; //跳转连接
@property (nonatomic, copy) NSString *ImageLink; //图片地址
@property (assign)NSInteger TotalVisit; //总浏览数
@property (assign)NSInteger commentCount; //评论数
@property (nonatomic, copy) NSString *Duration; //视频长度
@property (nonatomic, copy) NSString *CategpryName; //组名称
@property (nonatomic, copy) NSString *CategoryId; //组id






@end
