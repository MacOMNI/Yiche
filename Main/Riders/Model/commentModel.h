//
//  commentModel.h
//  YiChe
//
//  Created by mac on 15-5-5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentModel : NSObject

@property (assign) NSInteger commentId;
@property (assign) NSInteger userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userAvatar;
@property (nonatomic, copy) NSString *publishTime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *toUserId;
@property (nonatomic, copy) NSString *toUserName;

@end
