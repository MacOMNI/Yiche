//
//  RidersTableViewCell.m
//  YiChe
//
//  Created by imac on 15-5-5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RidersTableViewCell.h"
#import "CheyouHomeModel.h"

@implementation RidersTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
//    imageView.layer.cornerRadius = 45;
//    imageView.clipsToBounds = YES;


}

-(void)setModel:(CheyouHomeModel *)model{

    _model = model;
    [self loadCheyouData];
}

- (void)loadCheyouData{
/*
 //新闻图片
 NSString *str = _news.picCover;
 NSURL *url = [NSURL URLWithString:str];
 [_homeImageView setImageWithURL:url];
 
 //新闻标题
 _newsSummaryLabel.text = _news.title;
 
 //新闻来源
 _sourceLabel.text = _news.src;
 
 //评论数
 if(_news.commentCount != 0){
 
 _CommentLabel.text = [NSString stringWithFormat:@"%ld评论",_news.commentCount];
 }
 */
    
 /*
  @property (assign) NSInteger topicId; //话题id
  @property (assign) NSInteger userId; //用户id
  @property (nonatomic, copy) NSString *userName; //用户名
  @property (nonatomic, copy) NSString *userAvatar; //用户头像
  @property (nonatomic, copy) NSString *pushTime; //发布时间
  @property (nonatomic, copy) NSString *forumName; //来源
  @property (nonatomic, copy) NSString *content; //内容
  @property (nonatomic, retain) NSMutableArray *imageList; //图片列表
  
  @property (assign) NSInteger agreeCount; //点赞数
  @property (nonatomic, retain) NSMutableArray *agree; //点赞列表
  @property (assign) NSInteger commentCount; //评论数
  @property (nonatomic, retain) NSMutableArray *comment; //评论列表
     @property (weak, nonatomic) IBOutlet UILabel *cityLabel;//城市
     @property (weak, nonatomic) IBOutlet UILabel *commentLabel;//评论label
     @property (weak, nonatomic) IBOutlet UIImageView *separateImage;//分割图片
     @property (weak, nonatomic) IBOutlet UIImageView *agreeImage;//点赞图片
     @property (weak, nonatomic) IBOutlet UILabel *agreeLabel;//点赞label
     @property (weak, nonatomic) IBOutlet UIView *detailCommentView;//评论详情

     */
  //用户头像
    NSString *str = _model.userAvatar;
    NSURL *url = [NSURL URLWithString:str];
    [_headerImage setImageWithURL:url];
    
    _headerImage.layer.cornerRadius = 20;
    _headerImage.clipsToBounds = YES;
    
   //用户名
    _nameLabel.text = _model.userName;
    
    //发布时间
    _timeLabel.text = [Utils formatString:_model.publishTime];
    
    //来源
    _sourceLabel.text = [NSString stringWithFormat:@"来自%@",_model.forumName];
    
    //关注按钮
    [_concernBtn setImage:[UIImage imageNamed:@"carFriend_recommend_Follow_normal_N@2x.png"] forState:UIControlStateNormal];
    
     [_concernBtn setImage:[UIImage imageNamed:@"carFriend_recommend_Follow_normal_H@2x.png"] forState:UIControlStateHighlighted];
    
    //所在城市
    _cityLabel.text = _model.location;
    
    //点赞图片
    [_agreeImage setImage:[UIImage imageNamed:@"carFriend_recommend_agree_N@2x.png"]];
    
    //点赞label
    [_commentImage setImage:[UIImage imageNamed:@"carFriend_recommend_comment_N@2x.png"]];
    
    //分割图片
    [_separateImage setImage:[UIImage imageNamed:@"carFriend_recommend_line@2x.png"]];
    
    //点赞数量
    _agreeLabel.text = [NSString stringWithFormat:@"%ld",_model.agreeCount];
    
    _commentLabel.text = [NSString stringWithFormat:@"%ld",_model.commentCount];

    _imageItemView.data = _model;

    _detailCommentView.model = _model;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreCommentBtn:(UIButton *)sender {
    
    
}

- (IBAction)concernBtn:(UIButton *)sender {
    
    
}
@end
