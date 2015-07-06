//
//  RidersTableViewCell.h
//  YiChe
//
//  Created by imac on 15-5-5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheyouHomeModel.h"
#import "CheYouView.h"
#import "CommentView.h"

@interface RidersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;  //头像图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;  //用户名
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//发布时间
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;//来源
@property (weak, nonatomic) IBOutlet UIImageView *brandImage;//汽车标志
@property (weak, nonatomic) IBOutlet UIButton *concernBtn;//关注按钮
@property (weak, nonatomic) IBOutlet CheYouView *imageItemView;//图片视图
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;//城市
//@property (weak, nonatomic) IBOutlet UILabel *contentLabel;//内容label
//@property (weak, nonatomic) IBOutlet UIImageView *commentImge;//评论图片
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;//评论label
@property (weak, nonatomic) IBOutlet UIImageView *separateImage;//分割图片
//@property (weak, nonatomic) IBOutlet UIImageView *agreeHeaderImage;//点赞头像1
//@property (weak, nonatomic) IBOutlet UIImageView *agreeHeaderImage2;//点赞头像2
//@property (weak, nonatomic) IBOutlet UIImageView *agreeHeaderImage3;//点赞头像3
//@property (weak, nonatomic) IBOutlet UIImageView *agreeHraderImage4;//点赞头像4
//@property (weak, nonatomic) IBOutlet UIImageView *agreeHeaderImage5;//点赞头像5
@property (weak, nonatomic) IBOutlet UIImageView *agreeImage;//点赞图片
@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;//点赞label
//@property (weak, nonatomic) IBOutlet UILabel *agreeCountLabel;//点赞数量label
@property (weak, nonatomic) IBOutlet CommentView *detailCommentView;//评论详情
//@property (weak, nonatomic) IBOutlet UIImageView *moreCommentImagae;//更多评论图片
//@property (weak, nonatomic) IBOutlet UIButton *moreCommentBtn;//更多评论按钮
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;

//- (IBAction)moreCommentBtn:(UIButton *)sender;

- (IBAction)concernBtn:(UIButton *)sender;




@property (nonatomic,retain) CheyouHomeModel *model;

@end
