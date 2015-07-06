//
//  HomeListCellTableViewCell.m
//  YiChe
//
//  Created by imac on 15-4-26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HomeListCellTableViewCell.h"
#import "NewsModel.h" 
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "common.h"

@implementation HomeListCellTableViewCell

- (void)awakeFromNib {

    self.backgroundColor = [UIColor clearColor];
    
}

//set方法通知系统
-(void)setNews:(NewsModel *)news{

    if(_news != news){
    
        _news = news;
    }
    [self setNeedsLayout];
    
}
- (void)layoutSubviews{

    [super layoutSubviews];
    
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
    
    

}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//
//    [self.superview bringSubviewToFront:self];
//    [super touchesEnded:touches withEvent:event];
//    
//    WebViewController *vc = [[WebViewController alloc]init];
//    vc.newsModel = _news;
//    vc.hidesBottomBarWhenPushed = YES;
//    
//    [self.viewController.navigationController pushViewController:vc animated:YES];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
