//
//  HomeListCellTableViewCell.h
//  YiChe
//
//  Created by imac on 15-4-26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;  //新闻model

@interface HomeListCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView; //新闻图片
@property (weak, nonatomic) IBOutlet UILabel *newsSummaryLabel;//新闻标题
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel; //来源
@property (weak, nonatomic) IBOutlet UILabel *CommentLabel;//评论

@property (nonatomic,retain) NewsModel *news;

@end
