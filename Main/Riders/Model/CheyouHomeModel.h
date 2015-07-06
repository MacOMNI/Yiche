//
//  CheyouHomeModel.h
//  YiChe
//
//  Created by mac on 15-5-5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheyouHomeModel : NSObject

@property (assign) NSInteger topicId; //话题id
@property (assign) NSInteger userId; //用户id
@property (nonatomic, copy) NSString *userName; //用户名
@property (nonatomic, copy) NSString *userAvatar; //用户头像
@property (nonatomic, copy) NSString *publishTime; //发布时间
@property (nonatomic, copy) NSString *forumName; //来源
@property (nonatomic, copy) NSString *content; //内容
@property (nonatomic, retain) NSMutableArray *imageList; //图片列表
@property (nonatomic,copy) NSString *location;//所在城市

@property (assign) NSInteger agreeCount; //点赞数
@property (nonatomic, retain) NSMutableArray *agree; //点赞列表
@property (assign) NSInteger commentCount; //评论数
@property (nonatomic, retain) NSMutableArray *comment; //评论列表

@property (nonatomic,assign)CGFloat cheyouHeight;//根据此数据计算出cell的高度

@end
