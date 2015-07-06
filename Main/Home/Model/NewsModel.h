//
//  NewsModel.h
//  YiChe
//
//  Created by imac on 15-4-28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (assign) NSInteger newsId; //新闻ID
@property (nonatomic,copy) NSString *picCover; //新闻图片
@property (nonatomic,copy) NSString *filePath; //打开跳转链接
@property (nonatomic,copy) NSString *title; //新闻标题
@property (nonatomic,copy) NSString *src; //新闻来源
@property (nonatomic,assign) NSInteger commentCount; //评论数
@property (nonatomic,assign) NSInteger type; //新闻类型

@property (nonatomic,copy) NSString *itemType; //标题类型

@end
